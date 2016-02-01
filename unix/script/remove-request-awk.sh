#!/bin/bash
# =============================================================================
# remove requests from a that begins with "web_custom_request", ends with "LAST" and contains 
# "GetSentinelInfoAction" or "ListenAction" or "KeepAlive"
#
#	web_custom_request("command_17",
#		"URL=http://{host_slbafrdvpap01_fr_intranet_9180}/live/DesktopActivePivotLive/command",
#		"Method=POST",
#		"TargetFrame=",
#		"Resource=0",
#		"RecContentType=application/json",
#		"Referer=http://{host_slbafrdvpap01_fr_intranet_9180}/live/ActivePivotLiveDesktop.html",
#		"Snapshot=t20.inf",
#		"Mode=HTML",
#		"EncType=text/x-gwt-rpc; charset=utf-8",
#		"Body=7|0|9|http://{host_slbafrdvpap01_fr_intranet_9180}/live/DesktopActivePivotLive/|477870F4F6641F6821257094EDA5063E|com.quartetfs.pivot.live.core.client.cmd.ICommandService|execute|com.quartetfs.pivot.live.core.shared.cmd.IAction|com.quartetfs.pivot.live.core.shared.session.impl.GetSentinelInfoAction/114040704|com.quartetfs.pivot.live.core.shared.SessionId/1793314824|{OracleAppJSESSIONID}|admin|1|2|3|4|1|5|6|0|7|8|A|9|",
#		LAST);
#
# =============================================================================awk '
BEGIN {flag=0; rec="" }
/web_custom_request/ {
	rec=""; flag=1 		# start recording the lines until the end of request bloc
}
flag==0 {
	printf "%s\n", $0	# no recording -> print the current line
}
flag==1 {
	rec=rec $0 ORS		# recording -> add the current line to the buffer
}
/LAST/ {				# end of request bloc
	if (flag==1 && (rec !~ "GetSentinelInfoAction") && (rec !~ "ListenAction") && (rec !~ "KeepAlive")) {
		printf "%s", rec	# the request is not to filter -> print the bloc to stdout
	}
	flag=0
}
' Action.c
