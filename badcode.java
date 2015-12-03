package north.marketaccess.irim.input.sources.reuters;

import java.util.HashMap;
import java.util.Map;

import north.marketaccess.irim.input.sources.reuters.beans.IRIMDataDictionary;
import north.marketaccess.irim.input.sources.reuters.beans.IRIMReutersCode;
import north.marketaccess.irim.input.sources.reuters.beans.IRIMReutersResults;
import north.marketaccess.irim.input.sources.reuters.beans.IRIMReutersSession;
import north.marketaccess.irim.input.sources.reuters.beans.IRIMReutersSessionImpl.JNIClient;
import north.marketaccess.irim.input.sources.reuters.beans.IRIMSubscriber;
import north.northreuters.jni.DataMsgType;
import north.northreuters.jni.EventType;

public class IrimNorthReutersClient {
    private static final org.apache.log4j.Logger log = org.apache.log4j.Logger.getLogger(IrimNorthReutersClient.class);
    protected String[] relevantFields;
    protected IRIMSubscriber subscriber;
    protected String reutersServiceName;
    // Give up NorthReuters subscription if no snapshot was retrieved
    // at the end of this timeout (in milliseconds).
    protected int reutersSubscriptionTimeout;
    // While retrieving a Reuters page, the main thread checks if this page's snapshot is present ;
    // if not, it sleeps for this hereunder delay until it checks for the snapshot again, and so forth.
    protected final int northReutersDispatchIterationDelay = 5;
    protected IRIMDataDictionary reutersFieldDictionary;
    protected Map<String, Map<String, String>> reutersInfo = new HashMap<String, Map<String, String>>();
    @SuppressWarnings("unused")
    //kept for swig reasons
    private JNIClient jniClient;

    public IrimNorthReutersClient(IRIMReutersSession session, String reutersServiceName, String[] relevantsFields,
            int reutersSubscriptionTimeout) {
        super();
        this.reutersServiceName = reutersServiceName;
        this.relevantFields = relevantsFields;
        this.reutersSubscriptionTimeout = reutersSubscriptionTimeout;
        subscriber = session.getSubscriber(this);
        reutersFieldDictionary = session.getDataDictionary();
    }

    public void newReutersEvent(IRIMReutersCode reutersCode, EventType eventType, DataMsgType dataMsgType,
            IRIMReutersResults reutersResults) {
        if (eventType == EventType.Data) {
            if (dataMsgType == DataMsgType.Image) {
                storeRelevantReutersFields(reutersCode, reutersResults);
                subscriber.unSubscribe(reutersCode);
            }
        }
    }

    public synchronized void storeRelevantReutersFields(IRIMReutersCode reutersCode, IRIMReutersResults reutersResults) {
        synchronized (reutersInfo) {
            for (String field : relevantFields) {
                int fid = reutersFieldDictionary.getFid(field);
                if (reutersResults.hasField(fid)) {
                    String ric = reutersCode.getItem();
                    if (ric != null && !"".equals(ric)) {
                        String value = reutersResults.getField(fid);
                        if (!reutersInfo.containsKey(ric)) {
                            reutersInfo.put(ric, new HashMap<String, String>());
                        }
                        Map<String, String> snapshot = reutersInfo.get(ric);
                        snapshot.put(field, value);
                    }
                }
            }
        }
    }

    private void waitForReutersPage(String ric, String ricType) {

        int maxIterations = reutersSubscriptionTimeout / northReutersDispatchIterationDelay;
        int iteration = 0;
        while (!reutersInfo.containsKey(ric) && iteration < maxIterations) {
            try {
                Thread.sleep(northReutersDispatchIterationDelay);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            iteration++;
        }

        if (iteration == maxIterations) {
            log.warn("Timeout (" + Integer.toString(reutersSubscriptionTimeout) + " ms) : unable to retrieve "
                    + ricType + " " + ric + " from NorthReuters. Maybe RIC " + ric + " does not exist.");
            subscriber.unSubscribe(new IRIMReutersCode(reutersServiceName, ric));
        }
    }

    protected Map<String, String> getReutersSnapshot(String ric, String itemType) {
        waitForReutersPage(ric, itemType);
        Map<String, String> map = new HashMap<String, String>();
        synchronized (reutersInfo) {
            if (!reutersInfo.containsKey(ric)) {
                return null;
            }
            Map<String, String> t = reutersInfo.get(ric);
            map.putAll(t);
            reutersInfo.remove(ric);
        }
        return map;
    }

    public void subscribe(String ric) {
        subscriber.subscribe(new IRIMReutersCode(reutersServiceName, ric));
    }

    public void setJniClient(JNIClient jniClient) {
        this.jniClient = jniClient;
    }
}
