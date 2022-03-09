Content-Type: multipart/mixed; boundary="===============2172889675192941472=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: Re: Usable link speed info from iwd?
Date: Wed, 09 Mar 2022 13:05:23 -0800
Message-ID: <10c9b49f24fe813ff10138e992295f1fc42b1b2d.camel@gmail.com>
In-Reply-To: ab667060-d8a4-6df9-45e7-978460169b61@blueridgenetworks.com

--===============2172889675192941472==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bruce,

On Wed, 2022-03-09 at 15:55 -0500, Bruce A. Johnson wrote:
> Does anyone have a recommendation on how to obtain usable link speed
> information from iwd? Not finding anything in the API, I resorted to
> the iw tool, and that gave me unbelievable information like:
> iw dev wlan0 link
> Connected to 94:a6:7e:e0:9b:10 (on wlan0)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SSID: NETGEAR62-5G
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 freq: 5180
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RX: 729218722 bytes (698037 pa=
ckets)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TX: 649796954 bytes (597324 pa=
ckets)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 signal: -36 dBm
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rx bitrate: 24.0 MBit/s
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tx bitrate: 6.0 MBit/s
> =

> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bss flags:=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 short-slot-time
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dtim period:=C2=A0=C2=A0=C2=A0=
 1
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 beacon int:=C2=A0=C2=A0=C2=A0=
=C2=A0 100
> When the connection was in this state, I was able to pass data with
> iperf3 at nearly 100 Mbps in either direction with no packet loss on
> the transmit and about 1% packet loss on the receive. When I moved
> the router 10-12 meters further away, iw reported a higher bit rate.
> (I couldn't test throughput because there was no connection on the
> WAN side in the new location.)
> # iw dev wlan0 link
> Connected to 94:a6:7e:e0:9b:10 (on wlan0)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SSID: NETGEAR62-5G
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 freq: 5180
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RX: 24944 bytes (170 packets)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TX: 1949 bytes (12 packets)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 signal: -64 dBm
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rx bitrate: 260.0 MBit/s VHT-M=
CS 3 80MHz short GI VHT-NSS 2
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tx bitrate: 6.0 MBit/s
> =

> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bss flags:=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 short-slot-time
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dtim period:=C2=A0=C2=A0=C2=A0=
 1
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 beacon int:=C2=A0=C2=A0=C2=A0=
=C2=A0 100
> I must have a misunderstanding of what those figures mean. Is it that
> the only reasonable indication of link quality is the signal
> strength?
Generally yes, the signal strength is going to be the biggest hint into
link quality. Most users simply do not care about knowing these details
which is why its not in the regular API (it also fluctuates a lot so a
property would constantly be sending DBus messages). We do have the
StationDiagnostic interface [1] which exposes more information. You can
try this out with iwctl: "station <wlan> show".

Note that whatever you're getting from iw will be no different than
what IWD exposes since its using the same NL80211 API to get the
information.

Thanks,
James

[1]=C2=A0https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/doc/s=
tation-diagnostic-api.txt


> -- =

> Bruce Johnson
> Chantilly, Virginia
> OpenPGP key ID: 296D1CD6F2B84CAB https://keys.openpgp.org/
> _______________________________________________
> iwd mailing list -- iwd(a)lists.01.org
> To unsubscribe send an email to iwd-leave(a)lists.01.org


--===============2172889675192941472==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGh0bWw+PGhlYWQ+CgogICAgCiAgPC9oZWFkPgogIDxib2R5PjxkaXY+SGkgQnJ1Y2UsPC9kaXY+
PGRpdj48YnI+PC9kaXY+PGRpdj5PbiBXZWQsIDIwMjItMDMtMDkgYXQgMTU6NTUgLTA1MDAsIEJy
dWNlIEEuIEpvaG5zb24gd3JvdGU6PC9kaXY+PGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSIgc3R5bGU9
Im1hcmdpbjowIDAgMCAuOGV4OyBib3JkZXItbGVmdDoycHggIzcyOWZjZiBzb2xpZDtwYWRkaW5n
LWxlZnQ6MWV4Ij48cD5Eb2VzIGFueW9uZSBoYXZlIGEgcmVjb21tZW5kYXRpb24gb24gaG93IHRv
IG9idGFpbiB1c2FibGUgbGluayBzcGVlZCBpbmZvcm1hdGlvbiBmcm9tIGl3ZD8gTm90IGZpbmRp
bmcgYW55dGhpbmcgaW4gdGhlIEFQSSwgSSByZXNvcnRlZCB0byB0aGUgaXcgdG9vbCwgYW5kIHRo
YXQgZ2F2ZSBtZSB1bmJlbGlldmFibGUgaW5mb3JtYXRpb24gbGlrZTo8L3A+PHByZT5pdyBkZXYg
d2xhbjAgbGluazwvcHJlPjxwcmU+Q29ubmVjdGVkIHRvIDk0OmE2OjdlOmUwOjliOjEwIChvbiB3
bGFuMCk8L3ByZT48cHJlPiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyBTU0lEOiBORVRHRUFSNjItNUc8L3ByZT48cHJlPiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyBmcmVxOiA1MTgwPC9wcmU+PHByZT4mbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgUlg6IDcyOTIxODcyMiBieXRlcyAoNjk4MDM3IHBhY2tl
dHMpPC9wcmU+PHByZT4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsg
VFg6IDY0OTc5Njk1NCBieXRlcyAoNTk3MzI0IHBhY2tldHMpPC9wcmU+PHByZT4mbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgc2lnbmFsOiAtMzYgZEJtPC9wcmU+PHBy
ZT4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgcnggYml0cmF0ZTog
MjQuMCBNQml0L3M8L3ByZT48cHJlPiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyB0eCBiaXRyYXRlOiA2LjAgTUJpdC9zPC9wcmU+PHByZT48YnI+PC9wcmU+PHByZT4m
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgYnNzIGZsYWdzOiZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBzaG9ydC1zbG90LXRpbWU8L3ByZT48cHJlPiZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBkdGltIHBlcmlvZDombmJzcDsm
bmJzcDsmbmJzcDsgMTwvcHJlPjxwcmU+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7IGJlYWNvbiBpbnQ6Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IDEwMDwvcHJlPjxw
PldoZW4gdGhlIGNvbm5lY3Rpb24gd2FzIGluIHRoaXMgc3RhdGUsIEkgd2FzIGFibGUgdG8gcGFz
cyBkYXRhIHdpdGggaXBlcmYzIGF0IG5lYXJseSAxMDAgTWJwcyBpbiBlaXRoZXIgZGlyZWN0aW9u
IHdpdGggbm8gcGFja2V0IGxvc3Mgb24gdGhlIHRyYW5zbWl0IGFuZCBhYm91dCAxJSBwYWNrZXQg
bG9zcyBvbiB0aGUgcmVjZWl2ZS4gV2hlbiBJIG1vdmVkIHRoZSByb3V0ZXIgMTAtMTIgbWV0ZXJz
IGZ1cnRoZXIgYXdheSwgaXcgcmVwb3J0ZWQgYSA8dT5oaWdoZXI8L3U+IGJpdCByYXRlLiAoSSBj
b3VsZG4ndCB0ZXN0IHRocm91Z2hwdXQgYmVjYXVzZSB0aGVyZSB3YXMgbm8gY29ubmVjdGlvbiBv
biB0aGUgV0FOIHNpZGUgaW4gdGhlIG5ldyBsb2NhdGlvbi4pPGJyPjwvcD48cHJlPiMgaXcgZGV2
IHdsYW4wIGxpbms8L3ByZT48cHJlPkNvbm5lY3RlZCB0byA5NDphNjo3ZTplMDo5YjoxMCAob24g
d2xhbjApPC9wcmU+PHByZT4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsgU1NJRDogTkVUR0VBUjYyLTVHPC9wcmU+PHByZT4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsgZnJlcTogNTE4MDwvcHJlPjxwcmU+Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IFJYOiAyNDk0NCBieXRlcyAoMTcwIHBhY2tldHMpPC9w
cmU+PHByZT4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgVFg6IDE5
NDkgYnl0ZXMgKDEyIHBhY2tldHMpPC9wcmU+PHByZT4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsgc2lnbmFsOiAtNjQgZEJtPC9wcmU+PHByZT4mbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgcnggYml0cmF0ZTogMjYwLjAgTUJpdC9zIFZI
VC1NQ1MgMyA4ME1IeiBzaG9ydCBHSSBWSFQtTlNTIDI8L3ByZT48cHJlPiZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyB0eCBiaXRyYXRlOiA2LjAgTUJpdC9zPC9wcmU+
PHByZT48YnI+PC9wcmU+PHByZT4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsgYnNzIGZsYWdzOiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBzaG9ydC1zbG90
LXRpbWU8L3ByZT48cHJlPiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyBkdGltIHBlcmlvZDombmJzcDsmbmJzcDsmbmJzcDsgMTwvcHJlPjxwcmU+Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGJlYWNvbiBpbnQ6Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7IDEwMDwvcHJlPjxwPkkgbXVzdCBoYXZlIGEgbWlzdW5kZXJzdGFuZGluZyBvZiB3
aGF0IHRob3NlIGZpZ3VyZXMgbWVhbi4gSXMgaXQgdGhhdCB0aGUgb25seSByZWFzb25hYmxlIGlu
ZGljYXRpb24gb2YgbGluayBxdWFsaXR5IGlzIHRoZSBzaWduYWwgc3RyZW5ndGg/PC9wPjwvYmxv
Y2txdW90ZT48ZGl2PkdlbmVyYWxseSB5ZXMsIHRoZSBzaWduYWwgc3RyZW5ndGggaXMgZ29pbmcg
dG8gYmUgdGhlIGJpZ2dlc3QgaGludCBpbnRvIGxpbmsgcXVhbGl0eS4gTW9zdCB1c2VycyBzaW1w
bHkgZG8gbm90IGNhcmUgYWJvdXQga25vd2luZyB0aGVzZSBkZXRhaWxzIHdoaWNoIGlzIHdoeSBp
dHMgbm90IGluIHRoZSByZWd1bGFyIEFQSSAoaXQgYWxzbyBmbHVjdHVhdGVzIGEgbG90IHNvIGEg
cHJvcGVydHkgd291bGQgY29uc3RhbnRseSBiZSBzZW5kaW5nIERCdXMgbWVzc2FnZXMpLiBXZSBk
byBoYXZlIHRoZSBTdGF0aW9uRGlhZ25vc3RpYyBpbnRlcmZhY2UgWzFdIHdoaWNoIGV4cG9zZXMg
bW9yZSBpbmZvcm1hdGlvbi4gWW91IGNhbiB0cnkgdGhpcyBvdXQgd2l0aCBpd2N0bDogInN0YXRp
b24gJmx0O3dsYW4mZ3Q7IHNob3ciLjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+Tm90ZSB0aGF0
IHdoYXRldmVyIHlvdSdyZSBnZXR0aW5nIGZyb20gaXcgd2lsbCBiZSBubyBkaWZmZXJlbnQgdGhh
biB3aGF0IElXRCBleHBvc2VzIHNpbmNlIGl0cyB1c2luZyB0aGUgc2FtZSBOTDgwMjExIEFQSSB0
byBnZXQgdGhlIGluZm9ybWF0aW9uLjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+VGhhbmtzLDwv
ZGl2PjxkaXY+SmFtZXM8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PlsxXSZuYnNwOzxhIGhyZWY9
Imh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9uZXR3b3JrL3dpcmVsZXNzL2l3ZC5naXQv
dHJlZS9kb2Mvc3RhdGlvbi1kaWFnbm9zdGljLWFwaS50eHQiPmh0dHBzOi8vZ2l0Lmtlcm5lbC5v
cmcvcHViL3NjbS9uZXR3b3JrL3dpcmVsZXNzL2l3ZC5naXQvdHJlZS9kb2Mvc3RhdGlvbi1kaWFn
bm9zdGljLWFwaS50eHQ8L2E+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGJs
b2NrcXVvdGUgdHlwZT0iY2l0ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4OyBib3JkZXItbGVm
dDoycHggIzcyOWZjZiBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij48cHJlPi0tIDwvcHJlPjxwcmU+
QnJ1Y2UgSm9obnNvbjwvcHJlPjxwcmU+Q2hhbnRpbGx5LCBWaXJnaW5pYTwvcHJlPjxwcmU+T3Bl
blBHUCBrZXkgSUQ6IDI5NkQxQ0Q2RjJCODRDQUIgPGEgY2xhc3M9Im1vei10eHQtbGluay1mcmVl
dGV4dCIgaHJlZj0iaHR0cHM6Ly9rZXlzLm9wZW5wZ3Aub3JnLyI+aHR0cHM6Ly9rZXlzLm9wZW5w
Z3Aub3JnLzwvYT48L3ByZT48ZGl2Pl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fPGJyPjwvZGl2PjxkaXY+aXdkIG1haWxpbmcgbGlzdCAtLSA8YSBocmVmPSJt
YWlsdG86aXdkQGxpc3RzLjAxLm9yZyI+aXdkQGxpc3RzLjAxLm9yZzwvYT48YnI+PC9kaXY+PGRp
dj5UbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIDxhIGhyZWY9Im1haWx0bzppd2QtbGVh
dmVAbGlzdHMuMDEub3JnIj5pd2QtbGVhdmVAbGlzdHMuMDEub3JnPC9hPjxicj48L2Rpdj48L2Js
b2NrcXVvdGU+PGRpdj48YnI+PC9kaXY+PGRpdj48c3Bhbj48L3NwYW4+PC9kaXY+PC9ib2R5Pjwv
aHRtbD4K

--===============2172889675192941472==--

