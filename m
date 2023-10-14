Received: from out-199.mta0.migadu.com (out-199.mta0.migadu.com [91.218.175.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032F46AB2
	for <iwd@lists.linux.dev>; Sat, 14 Oct 2023 09:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kazlauskas.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kazlauskas.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kazlauskas.me header.i=@kazlauskas.me header.b="j9ve3kM4"
Date: Sat, 14 Oct 2023 12:23:53 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kazlauskas.me;
	s=key1; t=1697275438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nG/npX4cpfLkPi92cCHVlofZ+2V7HfIjP+SltxyprW0=;
	b=j9ve3kM4fWK6qvlay2ouwW1Bu7p8qndVMyMjE1FYrnLhVso+4seqw6Ty4pD7GkC28WeWoL
	vUqIiAzrFf+T2Vya7CpQ4MVJpLe7ZUIpLStCa11rLRVlHjhsKPDQiiuS6e9KidDP52O/0H
	U/psqpioGoA5UDEtNRPBIbfLvWjq3N0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Simonas Kazlauskas <iwd.lists.linux.dev@kazlauskas.me>
To: iwd@lists.linux.dev
Subject: Is the data rate estimation for 5GHz channels overly pessimistic?
Message-ID: <xxpypqwyk3gjrwjmpuvxqdlipkrb3fbw7augfey5ovr3lgbgul@2tbf6xw2uo3z>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="6yplcyhnbxsxpopd"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


--6yplcyhnbxsxpopd
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello everyone,

I’ve been seeing some weird behaviour with iwd in my environment with multiple 
Unifi access points, which has led me to run iwd with debug mode enabled that 
I look through once in a while. I anticipate writing more about my woes in the 
future, but this is the most apparent weirdness I’ve seen.

In my situation, when a scan occurs, I’m seeing that 2.4GHz channels will have 
throughput estimations that consider be realistic – the data rates reflect the 
rates I get after connecting to those APs. On the other hand, the estimated 
rate for 5GHz channels is extremely low & incorrect from what I can tell:

     [2023-10-14 11:23:46.006184] src/station.c:station_add_seen_bss() Processing BSS '00:00:00:00:00:01' with SSID: SSID1, freq: 2437, rank: 1126, strength: -6600, data_rate: 137.6
     [2023-10-14 11:23:46.006293] src/station.c:station_add_seen_bss() Processing BSS '00:00:00:00:00:02' with SSID: SSID2, freq: 2437, rank: 1126, strength: -6600, data_rate: 137.6
     [2023-10-14 11:23:46.006405] src/station.c:station_add_seen_bss() Processing BSS '00:00:00:00:00:03' with SSID: SSID3, freq: 2437, rank: 844, strength: -6700, data_rate: 103.2
     [2023-10-14 11:23:46.006514] src/station.c:station_add_seen_bss() Processing BSS '00:00:00:00:00:04' with SSID: SSID4, freq: 2437, rank: 844, strength: -6700, data_rate: 103.2
     [2023-10-14 11:23:46.006618] src/station.c:station_add_seen_bss() Processing BSS '00:00:00:00:00:05' with SSID: SSID3, freq: 2462, rank: 422, strength: -7600, data_rate: 51.6
     [2023-10-14 11:23:46.006731] src/station.c:station_add_seen_bss() Processing BSS '00:00:00:00:00:06' with SSID: SSID4, freq: 2462, rank: 422, strength: -7600, data_rate: 51.6
     [2023-10-14 11:23:46.006889] src/station.c:station_add_seen_bss() Processing BSS '00:00:00:00:00:07' with SSID: SSID2, freq: 2462, rank: 422, strength: -7600, data_rate: 51.6
     [2023-10-14 11:23:46.007017] src/station.c:station_add_seen_bss() Processing BSS '00:00:00:00:00:08' with SSID: SSID1, freq: 2462, rank: 422, strength: -7600, data_rate: 51.6
     [2023-10-14 11:23:46.007135] src/station.c:station_add_seen_bss() Processing BSS '00:00:00:00:00:09' with SSID: SSID3, freq: 5180, rank: 140, strength: -8000, data_rate: 17.2
     [2023-10-14 11:23:46.007259] src/station.c:station_add_seen_bss() Processing BSS '00:00:00:00:00:10' with SSID: SSID1, freq: 5180, rank: 140, strength: -8000, data_rate: 17.2
     [2023-10-14 11:23:46.007374] src/station.c:station_add_seen_bss() Processing BSS '00:00:00:00:00:11' with SSID: SSID3, freq: 5220, rank: 16, strength: -9200, data_rate: 2.0
     [2023-10-14 11:23:46.007474] src/station.c:station_add_seen_bss() Processing BSS '00:00:00:00:00:12' with SSID: SSID1, freq: 5220, rank: 16, strength: -9200, data_rate: 2.0

This leads iwd to try connecting to the 2.4GHz channels first as they're 
ranked higher. Authentications to those channels timeout, which I believe is 
caused by the band steering being enabled on the APs. So eventually IWD 
connects to the 00:00:00:00:00:10 AP anyway.

Once it does that, iwctl shows rates in the region of 200-300Mbps, which is 
what I observe in practice as well, and a big difference from the 17.2Mbps 
that iwd estimated initially:

     RSSI                  -78 dBm
     AverageRSSI           -79 dBm
     RxMode                802.11ax
     RxMCS                 8
     TxMode                802.11ax
     TxMCS                 4
     TxBitrate             206400 Kbit/s
     RxBitrate             206500 Kbit/s


Is it expected to be that way? If nothing else, this misestimation I believe 
results in WiFi connection times to increase from sub-second to at least 1.5 
seconds, due to waiting for all the 2.4GHz channels to timeout authenticating 
first. I’ve attached the entirety of my iwd debug log (with redacted BSSs and 
SSIDs) from today.

For posteriority my config contains these entries:

     [General]
     EnableNetworkConfiguration=false
     RoamRetryInterval=120
     RoamThreshold=1
     RoamThreshold5G=-85
     UseDefaultInterface=false

     [Rank]
     BandModifier5GHz=5.000000

but as far as my code reading goes none of them should affect the data_rate estimation.

--6yplcyhnbxsxpopd
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename=log

[2023-10-14 11:23:45.425115] src/netdev.c:netdev_mlme_notify() MLME notification Del Station(20)
[2023-10-14 11:23:45.425896] src/netdev.c:netdev_link_notify() event 16 on ifindex 6
[2023-10-14 11:23:45.426149] src/netdev.c:netdev_mlme_notify() MLME notification Deauthenticate(39)
[2023-10-14 11:23:45.426301] src/netdev.c:netdev_deauthenticate_event()
[2023-10-14 11:23:45.426587] src/netdev.c:netdev_link_notify() event 16 on ifindex 6
[2023-10-14 11:23:45.426853] src/netdev.c:netdev_mlme_notify() MLME notification Disconnect(48)
[2023-10-14 11:23:45.427113] src/netdev.c:netdev_disconnect_event()
[2023-10-14 11:23:45.429020] Received Deauthentication event, reason: 3, from_ap: false
[2023-10-14 11:23:45.429371] src/station.c:station_disconnect_event() 6
[2023-10-14 11:23:45.429674] src/station.c:station_disassociated() 6
[2023-10-14 11:23:45.429990] src/station.c:station_reset_connection_state() 6
[2023-10-14 11:23:45.430338] src/station.c:station_roam_state_clear() 6
[2023-10-14 11:23:45.430649] src/station.c:station_enter_state() Old State: connected, new state: disconnected
[2023-10-14 11:23:45.430988] src/station.c:station_enter_state() Old State: disconnected, new state: autoconnect_quick
[2023-10-14 11:23:45.431300] src/wiphy.c:wiphy_radio_work_insert() Inserting work item 6
[2023-10-14 11:23:45.431601] src/wiphy.c:wiphy_radio_work_next() Starting work item 6
[2023-10-14 11:23:45.431914] src/wiphy.c:wiphy_reg_notify() Notification of command Wiphy Reg Change(113)
[2023-10-14 11:23:45.432223] src/wiphy.c:wiphy_update_reg_domain() New reg domain country code for phy0 is XX
[2023-10-14 11:23:45.432515] src/scan.c:scan_notify() Scan notification Trigger Scan(33)
[2023-10-14 11:23:45.432810] src/scan.c:scan_request_triggered() Active scan triggered for wdev 6
[2023-10-14 11:23:45.433122] src/station.c:station_quick_scan_triggered() Quick scan triggered for wlan0
[2023-10-14 11:23:45.994947] src/wiphy.c:wiphy_reg_notify() Notification of command Wiphy Reg Change(113)
[2023-10-14 11:23:45.995156] src/wiphy.c:wiphy_update_reg_domain() New reg domain country code for phy0 is LT
[2023-10-14 11:23:46.003086] src/scan.c:scan_notify() Scan notification New Scan Results(34)
[2023-10-14 11:23:46.003349] src/netdev.c:netdev_link_notify() event 16 on ifindex 6
[2023-10-14 11:23:46.003461] src/scan.c:get_scan_callback() get_scan_callback
[2023-10-14 11:23:46.003548] src/scan.c:scan_parse_bss_information_elements() Load: 36/255
[2023-10-14 11:23:46.003633] src/scan.c:get_scan_callback() get_scan_callback
[2023-10-14 11:23:46.003716] src/scan.c:scan_parse_bss_information_elements() Load: 36/255
[2023-10-14 11:23:46.003841] src/scan.c:get_scan_callback() get_scan_callback
[2023-10-14 11:23:46.003963] src/scan.c:scan_parse_bss_information_elements() Load: 36/255
[2023-10-14 11:23:46.004073] src/scan.c:get_scan_callback() get_scan_callback
[2023-10-14 11:23:46.004178] src/scan.c:scan_parse_bss_information_elements() Load: 36/255
[2023-10-14 11:23:46.004294] src/scan.c:get_scan_callback() get_scan_callback
[2023-10-14 11:23:46.004401] src/scan.c:scan_parse_bss_information_elements() Load: 40/255
[2023-10-14 11:23:46.004509] src/scan.c:get_scan_callback() get_scan_callback
[2023-10-14 11:23:46.004614] src/scan.c:scan_parse_bss_information_elements() Load: 40/255
[2023-10-14 11:23:46.004724] src/scan.c:get_scan_callback() get_scan_callback
[2023-10-14 11:23:46.004853] src/scan.c:scan_parse_bss_information_elements() Load: 40/255
[2023-10-14 11:23:46.004971] src/scan.c:get_scan_callback() get_scan_callback
[2023-10-14 11:23:46.005083] src/scan.c:scan_parse_bss_information_elements() Load: 40/255
[2023-10-14 11:23:46.005191] src/scan.c:get_scan_callback() get_scan_callback
[2023-10-14 11:23:46.005297] src/scan.c:scan_parse_bss_information_elements() Load: 4/255
[2023-10-14 11:23:46.005401] src/scan.c:get_scan_callback() get_scan_callback
[2023-10-14 11:23:46.005510] src/scan.c:scan_parse_bss_information_elements() Load: 4/255
[2023-10-14 11:23:46.005621] src/scan.c:get_scan_callback() get_scan_callback
[2023-10-14 11:23:46.005731] src/scan.c:scan_parse_bss_information_elements() Load: 3/255
[2023-10-14 11:23:46.005856] src/scan.c:get_scan_callback() get_scan_callback
[2023-10-14 11:23:46.005973] src/scan.c:scan_parse_bss_information_elements() Load: 3/255
[2023-10-14 11:23:46.006079] src/scan.c:get_scan_done() get_scan_done
[2023-10-14 11:23:46.006184] src/station.c:station_add_seen_bss() Processing BSS '00:00:00:00:00:01' with SSID: SSID1, freq: 2437, rank: 1126, strength: -6600, data_rate: 137.6
[2023-10-14 11:23:46.006293] src/station.c:station_add_seen_bss() Processing BSS '00:00:00:00:00:02' with SSID: SSID2, freq: 2437, rank: 1126, strength: -6600, data_rate: 137.6
[2023-10-14 11:23:46.006405] src/station.c:station_add_seen_bss() Processing BSS '00:00:00:00:00:03' with SSID: SSID3, freq: 2437, rank: 844, strength: -6700, data_rate: 103.2
[2023-10-14 11:23:46.006514] src/station.c:station_add_seen_bss() Processing BSS '00:00:00:00:00:04' with SSID: SSID4, freq: 2437, rank: 844, strength: -6700, data_rate: 103.2
[2023-10-14 11:23:46.006618] src/station.c:station_add_seen_bss() Processing BSS '00:00:00:00:00:05' with SSID: SSID3, freq: 2462, rank: 422, strength: -7600, data_rate: 51.6
[2023-10-14 11:23:46.006731] src/station.c:station_add_seen_bss() Processing BSS '00:00:00:00:00:06' with SSID: SSID4, freq: 2462, rank: 422, strength: -7600, data_rate: 51.6
[2023-10-14 11:23:46.006889] src/station.c:station_add_seen_bss() Processing BSS '00:00:00:00:00:07' with SSID: SSID2, freq: 2462, rank: 422, strength: -7600, data_rate: 51.6
[2023-10-14 11:23:46.007017] src/station.c:station_add_seen_bss() Processing BSS '00:00:00:00:00:08' with SSID: SSID1, freq: 2462, rank: 422, strength: -7600, data_rate: 51.6
[2023-10-14 11:23:46.007135] src/station.c:station_add_seen_bss() Processing BSS '00:00:00:00:00:09' with SSID: SSID3, freq: 5180, rank: 140, strength: -8000, data_rate: 17.2
[2023-10-14 11:23:46.007259] src/station.c:station_add_seen_bss() Processing BSS '00:00:00:00:00:10' with SSID: SSID1, freq: 5180, rank: 140, strength: -8000, data_rate: 17.2
[2023-10-14 11:23:46.007374] src/station.c:station_add_seen_bss() Processing BSS '00:00:00:00:00:11' with SSID: SSID3, freq: 5220, rank: 16, strength: -9200, data_rate: 2.0
[2023-10-14 11:23:46.007474] src/station.c:station_add_seen_bss() Processing BSS '00:00:00:00:00:12' with SSID: SSID1, freq: 5220, rank: 16, strength: -9200, data_rate: 2.0
[2023-10-14 11:23:46.007558] src/station.c:station_autoconnect_start()
[2023-10-14 11:23:46.007657] src/wiphy.c:wiphy_select_akm() Network is WPA3-Personal...
[2023-10-14 11:23:46.007763] src/station.c:station_autoconnect_next() autoconnect: Trying SSID: SSID1
[2023-10-14 11:23:46.007895] src/station.c:station_autoconnect_next() autoconnect: '00:00:00:00:00:01' freq: 2437, rank: 1126, strength: -6600
[2023-10-14 11:23:46.008010] src/wiphy.c:wiphy_select_akm() Network is WPA3-Personal...
[2023-10-14 11:23:46.008130] src/netdev.c:netdev_cqm_rssi_update()
[2023-10-14 11:23:46.008233] src/wiphy.c:wiphy_radio_work_insert() Inserting work item 7
[2023-10-14 11:23:46.008327] src/station.c:__station_connect_network() connecting to BSS 00:00:00:00:00:01
[2023-10-14 11:23:46.008438] src/station.c:station_enter_state() Old State: autoconnect_quick, new state: connecting (auto)
[2023-10-14 11:23:46.008572] src/scan.c:scan_cancel() Trying to cancel scan id 6 for wdev 6
[2023-10-14 11:23:46.008690] src/wiphy.c:wiphy_radio_work_done() Work item 6 done
[2023-10-14 11:23:46.008869] src/wiphy.c:wiphy_radio_work_next() Starting work item 7
[2023-10-14 11:23:46.042487] CMD_SET_CQM failed: Invalid argument
[2023-10-14 11:23:46.048545] src/netdev.c:netdev_mlme_notify() MLME notification New Station(19)
[2023-10-14 11:23:46.079448] src/netdev.c:netdev_mlme_notify() MLME notification Authenticate(37)
[2023-10-14 11:23:46.079688] src/netdev.c:netdev_authenticate_event()
[2023-10-14 11:23:46.107648] src/netdev.c:netdev_mlme_notify() MLME notification Del Station(20)
[2023-10-14 11:23:46.107927] src/netdev.c:netdev_mlme_notify() MLME notification New Station(19)
[2023-10-14 11:23:46.206679] src/netdev.c:netdev_mlme_notify() MLME notification Authenticate(37)
[2023-10-14 11:23:46.206932] src/netdev.c:netdev_authenticate_event()
[2023-10-14 11:23:46.231296] src/netdev.c:netdev_mlme_notify() MLME notification Authenticate(37)
[2023-10-14 11:23:46.231527] src/netdev.c:netdev_authenticate_event()
[2023-10-14 11:23:46.561747] src/netdev.c:netdev_mlme_notify() MLME notification Del Station(20)
[2023-10-14 11:23:46.562371] src/netdev.c:netdev_mlme_notify() MLME notification Associate(38)
[2023-10-14 11:23:46.562562] src/netdev.c:netdev_associate_event()
[2023-10-14 11:23:46.562682] association timed out
[2023-10-14 11:23:46.562797] Error sending CMD_ASSOCIATE (-2)
[2023-10-14 11:23:46.563514] src/wiphy.c:wiphy_radio_work_done() Work item 7 done
[2023-10-14 11:23:46.563629] src/station.c:station_connect_cb() 6, result: 2
[2023-10-14 11:23:46.563733] src/wiphy.c:wiphy_select_akm() Network is WPA3-Personal...
[2023-10-14 11:23:46.563906] src/wiphy.c:wiphy_select_akm() Network is WPA3-Personal...
[2023-10-14 11:23:46.564017] src/netdev.c:netdev_cqm_rssi_update()
[2023-10-14 11:23:46.564121] src/wiphy.c:wiphy_radio_work_insert() Inserting work item 8
[2023-10-14 11:23:46.564222] src/wiphy.c:wiphy_radio_work_next() Starting work item 8
[2023-10-14 11:23:46.600850] src/station.c:__station_connect_network() connecting to BSS 00:00:00:00:00:01
[2023-10-14 11:23:46.601012] src/station.c:station_try_next_bss() Attempting to connect to next BSS 00:00:00:00:00:01
[2023-10-14 11:23:46.601105] CMD_SET_CQM failed: Invalid argument
[2023-10-14 11:23:46.601193] src/netdev.c:netdev_auth_cb() Error during auth: -2
[2023-10-14 11:23:46.602065] src/scan.c:scan_notify() Scan notification Trigger Scan(33)
[2023-10-14 11:23:46.719156] src/netdev.c:netdev_new_scan_results_event()
[2023-10-14 11:23:46.719398] src/scan.c:scan_notify() Scan notification New Scan Results(34)
[2023-10-14 11:23:46.719496] src/netdev.c:netdev_link_notify() event 16 on ifindex 6
[2023-10-14 11:23:46.722773] src/netdev.c:netdev_mlme_notify() MLME notification New Station(19)
[2023-10-14 11:23:46.761627] src/netdev.c:netdev_mlme_notify() MLME notification Authenticate(37)
[2023-10-14 11:23:46.761853] src/netdev.c:netdev_authenticate_event()
[2023-10-14 11:23:46.761968] src/wiphy.c:wiphy_radio_work_done() Work item 8 done
[2023-10-14 11:23:46.762059] src/station.c:station_connect_cb() 6, result: 1
[2023-10-14 11:23:46.762135] src/wiphy.c:wiphy_select_akm() Network is WPA3-Personal...
[2023-10-14 11:23:46.762252] src/wiphy.c:wiphy_select_akm() Network is WPA3-Personal...
[2023-10-14 11:23:46.762373] src/netdev.c:netdev_cqm_rssi_update()
[2023-10-14 11:23:46.762451] src/wiphy.c:wiphy_radio_work_insert() Inserting work item 9
[2023-10-14 11:23:46.762521] src/wiphy.c:wiphy_radio_work_next() Starting work item 9
[2023-10-14 11:23:46.794606] src/station.c:__station_connect_network() connecting to BSS 00:00:00:00:00:01
[2023-10-14 11:23:46.794775] src/station.c:station_try_next_bss() Attempting to connect to next BSS 00:00:00:00:00:01
[2023-10-14 11:23:46.794922] src/netdev.c:netdev_mlme_notify() MLME notification Del Station(20)
[2023-10-14 11:23:46.795024] CMD_SET_CQM failed: Invalid argument
[2023-10-14 11:23:46.798169] src/netdev.c:netdev_mlme_notify() MLME notification New Station(19)
[2023-10-14 11:23:46.840398] src/netdev.c:netdev_mlme_notify() MLME notification Authenticate(37)
[2023-10-14 11:23:46.840634] src/netdev.c:netdev_authenticate_event()
[2023-10-14 11:23:46.840734] src/wiphy.c:wiphy_radio_work_done() Work item 9 done
[2023-10-14 11:23:46.840857] src/station.c:station_connect_cb() 6, result: 1
[2023-10-14 11:23:46.840984] src/wiphy.c:wiphy_select_akm() Network is WPA3-Personal...
[2023-10-14 11:23:46.841149] src/wiphy.c:wiphy_select_akm() Network is WPA3-Personal...
[2023-10-14 11:23:46.841264] src/wiphy.c:wiphy_select_akm() Network is WPA3-Personal...
[2023-10-14 11:23:46.841352] src/netdev.c:netdev_cqm_rssi_update()
[2023-10-14 11:23:46.841434] src/wiphy.c:wiphy_radio_work_insert() Inserting work item 10
[2023-10-14 11:23:46.841514] src/wiphy.c:wiphy_radio_work_next() Starting work item 10
[2023-10-14 11:23:46.876036] src/station.c:__station_connect_network() connecting to BSS 00:00:00:00:00:08
[2023-10-14 11:23:46.876203] src/station.c:station_try_next_bss() Attempting to connect to next BSS 00:00:00:00:00:08
[2023-10-14 11:23:46.876295] src/netdev.c:netdev_mlme_notify() MLME notification Del Station(20)
[2023-10-14 11:23:46.876383] CMD_SET_CQM failed: Invalid argument
[2023-10-14 11:23:46.879488] src/netdev.c:netdev_mlme_notify() MLME notification New Station(19)
[2023-10-14 11:23:46.916611] src/netdev.c:netdev_mlme_notify() MLME notification Authenticate(37)
[2023-10-14 11:23:46.916882] src/netdev.c:netdev_authenticate_event()
[2023-10-14 11:23:46.929372] src/netdev.c:netdev_mlme_notify() MLME notification Del Station(20)
[2023-10-14 11:23:46.936504] src/netdev.c:netdev_mlme_notify() MLME notification New Station(19)
[2023-10-14 11:23:47.054721] src/netdev.c:netdev_mlme_notify() MLME notification Authenticate(37)
[2023-10-14 11:23:47.055000] src/netdev.c:netdev_authenticate_event()
[2023-10-14 11:23:47.093228] src/netdev.c:netdev_mlme_notify() MLME notification Authenticate(37)
[2023-10-14 11:23:47.093504] src/netdev.c:netdev_authenticate_event()
[2023-10-14 11:23:47.420248] src/netdev.c:netdev_mlme_notify() MLME notification Del Station(20)
[2023-10-14 11:23:47.420911] src/netdev.c:netdev_mlme_notify() MLME notification Associate(38)
[2023-10-14 11:23:47.421097] src/netdev.c:netdev_associate_event()
[2023-10-14 11:23:47.421221] association timed out
[2023-10-14 11:23:47.421345] Error sending CMD_ASSOCIATE (-2)
[2023-10-14 11:23:47.421456] src/wiphy.c:wiphy_radio_work_done() Work item 10 done
[2023-10-14 11:23:47.421567] src/station.c:station_connect_cb() 6, result: 2
[2023-10-14 11:23:47.421680] src/wiphy.c:wiphy_select_akm() Network is WPA3-Personal...
[2023-10-14 11:23:47.421788] src/wiphy.c:wiphy_select_akm() Network is WPA3-Personal...
[2023-10-14 11:23:47.421935] src/wiphy.c:wiphy_select_akm() Network is WPA3-Personal...
[2023-10-14 11:23:47.422049] src/wiphy.c:wiphy_select_akm() Network is WPA3-Personal...
[2023-10-14 11:23:47.422157] src/netdev.c:netdev_cqm_rssi_update()
[2023-10-14 11:23:47.422266] src/wiphy.c:wiphy_radio_work_insert() Inserting work item 11
[2023-10-14 11:23:47.422373] src/wiphy.c:wiphy_radio_work_next() Starting work item 11
[2023-10-14 11:23:47.456508] src/station.c:__station_connect_network() connecting to BSS 00:00:00:00:00:10
[2023-10-14 11:23:47.456688] src/station.c:station_try_next_bss() Attempting to connect to next BSS 00:00:00:00:00:10
[2023-10-14 11:23:47.461036] src/netdev.c:netdev_mlme_notify() MLME notification New Station(19)
[2023-10-14 11:23:47.492314] src/netdev.c:netdev_mlme_notify() MLME notification Authenticate(37)
[2023-10-14 11:23:47.492529] src/netdev.c:netdev_authenticate_event()
[2023-10-14 11:23:47.505915] src/netdev.c:netdev_mlme_notify() MLME notification Del Station(20)
[2023-10-14 11:23:47.510470] src/netdev.c:netdev_mlme_notify() MLME notification New Station(19)
[2023-10-14 11:23:47.598257] src/netdev.c:netdev_mlme_notify() MLME notification Authenticate(37)
[2023-10-14 11:23:47.598489] src/netdev.c:netdev_authenticate_event()
[2023-10-14 11:23:47.623158] src/netdev.c:netdev_mlme_notify() MLME notification Authenticate(37)
[2023-10-14 11:23:47.623496] src/netdev.c:netdev_authenticate_event()
[2023-10-14 11:23:47.634026] src/netdev.c:netdev_mlme_notify() MLME notification Associate(38)
[2023-10-14 11:23:47.634324] src/netdev.c:netdev_associate_event()
[2023-10-14 11:23:47.634481] src/netdev.c:netdev_mlme_notify() MLME notification Connect(46)
[2023-10-14 11:23:47.634585] src/netdev.c:netdev_connect_event()
[2023-10-14 11:23:47.634680] src/netdev.c:netdev_connect_event() aborting and ignore_connect_event not set, proceed
[2023-10-14 11:23:47.634773] src/netdev.c:netdev_connect_event() expect_connect_failure not set, proceed
[2023-10-14 11:23:47.634910] src/netdev.c:parse_request_ies()
[2023-10-14 11:23:47.635032] src/netdev.c:netdev_connect_event() Request / Response IEs parsed
[2023-10-14 11:23:47.635126] src/netdev.c:netdev_get_oci()
[2023-10-14 11:23:47.635218] src/netdev.c:netdev_link_notify() event 16 on ifindex 6
[2023-10-14 11:23:47.635312] src/netdev.c:netdev_link_notify() event 16 on ifindex 6
[2023-10-14 11:23:47.635403] src/netdev.c:netdev_get_oci_cb() Obtained OCI: freq: 5180, width: 2, center1: 5190, center2: 0
[2023-10-14 11:23:47.635495] src/eapol.c:eapol_start()
[2023-10-14 11:23:47.635595] src/netdev.c:netdev_link_notify() event 16 on ifindex 6
[2023-10-14 11:23:47.635688] src/netdev.c:netdev_link_notify() event 16 on ifindex 6
[2023-10-14 11:23:47.661940] src/netdev.c:netdev_unicast_notify() Unicast notification Control Port Frame(129)
[2023-10-14 11:23:47.662104] src/netdev.c:netdev_control_port_frame_event()
[2023-10-14 11:23:47.662189] src/eapol.c:eapol_handle_ptk_1_of_4() ifindex=6
[2023-10-14 11:23:47.663891] src/netdev.c:netdev_mlme_notify() MLME notification Control Port TX Status(139)
[2023-10-14 11:23:47.667478] src/netdev.c:netdev_unicast_notify() Unicast notification Control Port Frame(129)
[2023-10-14 11:23:47.667586] src/netdev.c:netdev_control_port_frame_event()
[2023-10-14 11:23:47.668080] src/eapol.c:eapol_handle_ptk_3_of_4() ifindex=6
[2023-10-14 11:23:47.668178] src/netdev.c:netdev_set_gtk() ifindex=6 key_idx=1
[2023-10-14 11:23:47.668235] src/netdev.c:netdev_set_igtk() ifindex=6 key_idx=4
[2023-10-14 11:23:47.668287] src/station.c:station_handshake_event() Setting keys
[2023-10-14 11:23:47.668339] src/netdev.c:netdev_set_tk() ifindex=6 key_idx=0
[2023-10-14 11:23:47.668388] src/netdev.c:netdev_set_rekey_offload() 6
[2023-10-14 11:23:47.680872] src/netdev.c:netdev_new_group_key_cb() ifindex: 6, err: 0
[2023-10-14 11:23:47.681042] src/netdev.c:try_handshake_complete() ptk_installed: 0, gtk_installed: 1, igtk_installed: 0
[2023-10-14 11:23:47.688708] src/netdev.c:netdev_new_group_management_key_cb() ifindex: 6, err: 0
[2023-10-14 11:23:47.688946] src/netdev.c:try_handshake_complete() ptk_installed: 0, gtk_installed: 1, igtk_installed: 1
[2023-10-14 11:23:47.694721] src/netdev.c:netdev_mlme_notify() MLME notification Control Port TX Status(139)
[2023-10-14 11:23:47.695985] src/netdev.c:netdev_set_station_cb()
[2023-10-14 11:23:47.696190] src/netdev.c:try_handshake_complete() ptk_installed: 1, gtk_installed: 1, igtk_installed: 1
[2023-10-14 11:23:47.696349] src/netdev.c:try_handshake_complete() nhs->complete: 0
[2023-10-14 11:23:47.696502] src/netdev.c:try_handshake_complete() Invoking handshake_event()
[2023-10-14 11:23:47.696655] src/netdev.c:netdev_connect_ok()
[2023-10-14 11:23:47.696817] src/station.c:station_connect_cb() 6, result: 0
[2023-10-14 11:23:47.697001] src/station.c:station_connect_ok()
[2023-10-14 11:23:47.697153] src/station.c:station_enter_state() Old State: connecting (auto), new state: connected
[2023-10-14 11:23:47.697370] src/wiphy.c:wiphy_radio_work_done() Work item 11 done
[2023-10-14 11:23:47.697510] src/netdev.c:netdev_link_notify() event 16 on ifindex 6
[2023-10-14 11:23:47.697604] src/netdev.c:netdev_mlme_notify() MLME notification Frame TX Status(60)
[2023-10-14 11:23:47.699295] src/station.c:station_early_neighbor_report_cb() ifindex: 6, error: 0()
[2023-10-14 11:23:47.699477] src/netdev.c:netdev_unicast_notify() Unicast notification Frame(59)
[2023-10-14 11:23:47.743312] src/netdev.c:netdev_mlme_notify() MLME notification Notify CQM(64)
[2023-10-14 11:23:47.743815] src/netdev.c:netdev_cqm_event() Signal change event (above=1 signal=-79)
[2023-10-14 11:27:14.568840] src/netdev.c:netdev_mlme_notify() MLME notification Notify CQM(64)
[2023-10-14 11:27:14.569147] src/netdev.c:netdev_cqm_event() Signal change event (above=1 signal=-70)

--6yplcyhnbxsxpopd--
