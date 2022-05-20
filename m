Content-Type: multipart/mixed; boundary="===============5768388329857381401=="
MIME-Version: 1.0
From: Michael Johnson <mjohnson459 at gmail.com>
To: iwd at lists.01.org
Subject: Unsupported finite cyclic group
Date: Fri, 20 May 2022 15:49:35 +0100
Message-ID: <CACsRnHXTXLj4A7M9+05m+rF54NiE=isBzpxYTWxah-UUZXqe7w@mail.gmail.com>

--===============5768388329857381401==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

After updating to master (f12cf1ab9db iwd, 43e99ec5f21 ell) I've
started seeing a few new errors which are causing the client to
disconnect and stay disconnected for a brief time. The previous
version I was running (1.21 iwd and 0.47 ell) didn't have these but
it's possible this is new functionality that was enabled and the AP
vendor doesn't support it properly. If there is anything else I can
gather to help debug what is going wrong please let me know.

The first error happens during an FT roam and the AP reports this
association failure: 802.11 STATUS (CODE 77) - Unsupported finite
cyclic group. Most FT roams happen fine so I'm not sure why this one
is different.
```
May 19 16:16:11.647803 r2-19105 iwd[462]:
src/station.c:station_enter_state() Old State: connected, new state:
roaming
May 19 16:16:11.647803 r2-19105 iwd[462]:
src/wiphy.c:wiphy_radio_work_done() Work item 201 done
May 19 16:16:11.647803 r2-19105 iwd[462]:
src/wiphy.c:wiphy_radio_work_next() Starting work item 202
May 19 16:16:11.692387 r2-19105 iwd[462]:
src/netdev.c:netdev_mlme_notify() MLME notification Del Station(20)
May 19 16:16:11.692387 r2-19105 iwd[462]:
src/netdev.c:netdev_link_notify() event 16 on ifindex 5
May 19 16:16:11.692387 r2-19105 iwd[462]:
src/netdev.c:netdev_mlme_notify() MLME notification Deauthenticate(39)
May 19 16:16:11.692588 r2-19105 iwd[462]:
src/netdev.c:netdev_deauthenticate_event()
May 19 16:16:11.692588 r2-19105 iwd[462]:
src/netdev.c:netdev_mlme_notify() MLME notification Disconnect(48)
May 19 16:16:11.692588 r2-19105 iwd[462]: src/netdev.c:netdev_disconnect_ev=
ent()
May 19 16:16:11.692588 r2-19105 iwd[462]:
src/netdev.c:netdev_mlme_notify() MLME notification New Station(19)
May 19 16:16:11.692588 r2-19105 iwd[462]:
src/netdev.c:netdev_link_notify() event 16 on ifindex 5
May 19 16:16:11.692588 r2-19105 iwd[462]:
src/wiphy.c:wiphy_reg_notify() Notification of command Reg Change(36)
May 19 16:16:11.692588 r2-19105 iwd[462]:
src/wiphy.c:wiphy_update_reg_domain() New reg domain country code for
(global) is XX
May 19 16:16:11.696000 r2-19105 iwd[462]:
src/netdev.c:netdev_mlme_notify() MLME notification Authenticate(37)
May 19 16:16:11.696000 r2-19105 iwd[462]:
src/netdev.c:netdev_authenticate_event()
May 19 16:16:11.696723 r2-19105 iwd[462]:
src/netdev.c:netdev_mlme_notify() MLME notification Del Station(20)
May 19 16:16:11.696723 r2-19105 iwd[462]:
src/netdev.c:netdev_mlme_notify() MLME notification Deauthenticate(39)
May 19 16:16:11.696848 r2-19105 iwd[462]:
src/netdev.c:netdev_deauthenticate_event()
May 19 16:16:11.696848 r2-19105 iwd[462]:
src/wiphy.c:wiphy_radio_work_done() Work item 202 done
May 19 16:16:11.696848 r2-19105 iwd[462]:
src/station.c:station_fast_transition_cb() 5, result: 2
May 19 16:16:11.696848 r2-19105 iwd[462]: src/station.c:station_roam_failed=
() 5
May 19 16:16:11.696848 r2-19105 iwd[462]:
src/station.c:station_disassociated() 5
May 19 16:16:11.696848 r2-19105 iwd[462]:
src/resolve.c:resolve_systemd_revert() ifindex: 5
```

The second error is a CMD_ASSOCIATE timeout which happens when trying
to autoconnect after the first error and so is possibly related.
```
May 19 16:16:12.812461 r2-19105 iwd[462]:
src/wiphy.c:wiphy_select_akm() Network is WPA3-Personal...
May 19 16:16:12.812461 r2-19105 iwd[462]: src/sae.c:sae_sm_new() Using
SAE Hunting and Pecking
May 19 16:16:12.812461 r2-19105 iwd[462]: src/netdev.c:netdev_cqm_rssi_upda=
te()
May 19 16:16:12.812461 r2-19105 iwd[462]:
src/wiphy.c:wiphy_radio_work_insert() Inserting work item 204
May 19 16:16:12.812461 r2-19105 iwd[462]:
src/station.c:__station_connect_network() connecting to BSS
f6:9e:38:*:*:*
May 19 16:16:12.812461 r2-19105 iwd[462]:
src/station.c:station_enter_state() Old State: autoconnect_quick, new
state: connecting (auto)
May 19 16:16:12.812461 r2-19105 iwd[462]: src/scan.c:scan_cancel()
Trying to cancel scan id 203 for wdev 2
May 19 16:16:12.812461 r2-19105 iwd[462]:
src/wiphy.c:wiphy_radio_work_done() Work item 203 done
May 19 16:16:12.812461 r2-19105 iwd[462]:
src/wiphy.c:wiphy_radio_work_next() Starting work item 204
May 19 16:16:12.863949 r2-19105 iwd[462]:
src/netdev.c:netdev_mlme_notify() MLME notification New Station(19)
May 19 16:16:12.865712 r2-19105 iwd[462]:
src/netdev.c:netdev_mlme_notify() MLME notification Authenticate(37)
May 19 16:16:12.865712 r2-19105 iwd[462]:
src/netdev.c:netdev_authenticate_event()
May 19 16:16:12.865712 r2-19105 iwd[462]:
src/sae.c:sae_verify_packet() rx trans=3D1, state=3Dcommitted
May 19 16:16:12.930662 r2-19105 iwd[462]:
src/netdev.c:netdev_mlme_notify() MLME notification Del Station(20)
May 19 16:16:12.930662 r2-19105 iwd[462]:
src/netdev.c:netdev_mlme_notify() MLME notification New Station(19)
May 19 16:16:12.946796 r2-19105 iwd[462]:
src/netdev.c:netdev_mlme_notify() MLME notification Authenticate(37)
May 19 16:16:12.946796 r2-19105 iwd[462]:
src/netdev.c:netdev_authenticate_event()
May 19 16:16:12.946796 r2-19105 iwd[462]:
src/sae.c:sae_verify_packet() rx trans=3D1, state=3Dcommitted
May 19 16:16:12.950893 r2-19105 iwd[462]:
src/netdev.c:netdev_mlme_notify() MLME notification Authenticate(37)
May 19 16:16:12.950893 r2-19105 iwd[462]:
src/netdev.c:netdev_authenticate_event()
May 19 16:16:12.950893 r2-19105 iwd[462]:
src/sae.c:sae_verify_packet() rx trans=3D2, state=3Dconfirmed
May 19 16:16:14.234437 r2-19105 iwd[462]:
src/netdev.c:netdev_mlme_notify() MLME notification Del Station(20)
May 19 16:16:14.234749 r2-19105 iwd[462]:
src/netdev.c:netdev_mlme_notify() MLME notification Associate(38)
May 19 16:16:14.234749 r2-19105 iwd[462]: src/netdev.c:netdev_associate_eve=
nt()
May 19 16:16:14.234749 r2-19105 iwd[462]: association timed out
May 19 16:16:14.234883 r2-19105 iwd[462]: Error sending CMD_ASSOCIATE (-2)
May 19 16:16:14.234883 r2-19105 iwd[462]:
src/wiphy.c:wiphy_radio_work_done() Work item 204 done
May 19 16:16:14.234883 r2-19105 iwd[462]:
src/station.c:station_connect_cb() 5, result: 2
```

Finally, after connecting (iwd eventually does the full eapol
handshake which reconnects) the request for the neighbor report times
out. This doesn't cause any disconnect but does cause another neighbor
request to be sent before roaming (which works).
```
May 19 16:50:54.229861 r2-19105 iwd[462]:
src/station.c:station_enter_state() Old State: roaming, new state:
connected
May 19 16:50:54.229861 r2-19105 iwd[462]:
src/wiphy.c:wiphy_radio_work_done() Work item 216 done
May 19 16:50:54.229861 r2-19105 iwd[462]:
src/netdev.c:netdev_link_notify() event 16 on ifindex 5
May 19 16:50:54.230062 r2-19105 iwd[462]:
src/netdev.c:netdev_mlme_notify() MLME notification Frame TX
Status(60)
May 19 16:50:54.623293 r2-19105 iwd[462]:
src/netdev.c:netdev_mlme_notify() MLME notification Notify CQM(64)
May 19 16:50:57.229499 r2-19105 iwd[462]:
src/station.c:station_early_neighbor_report_cb() ifindex: 5, error:
-110(Connection timed out)
...
May 19 17:00:54.060111 r2-19105 iwd[462]:
src/station.c:station_roam_trigger_cb() 5
May 19 17:00:54.060111 r2-19105 iwd[462]:
src/station.c:station_roam_trigger_cb() Requesting neighbor report for
roam
May 19 17:00:54.060492 r2-19105 iwd[462]:
src/netdev.c:netdev_mlme_notify() MLME notification Frame TX
Status(60)
May 19 17:00:54.061519 r2-19105 iwd[462]:
src/netdev.c:netdev_unicast_notify() Unicast notification Frame(59)
May 19 17:00:54.061519 r2-19105 iwd[462]:
src/station.c:station_neighbor_report_cb() ifindex: 5, error: 0()
May 19 17:00:54.061519 r2-19105 iwd[462]:
src/station.c:parse_neighbor_report() Neighbor report received for
f6:9e:38:*:*:*: ch 149 (oper class 3), MD not set
```

Regards,
Michael
--===============5768388329857381401==--

