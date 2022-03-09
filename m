Content-Type: multipart/mixed; boundary="===============6541155774290714996=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: Re: Usable link speed info from iwd?
Date: Wed, 09 Mar 2022 14:19:39 -0800
Message-ID: <530a6a543af8f457fc91312410c3994499aad9ea.camel@gmail.com>
In-Reply-To: ab667060-d8a4-6df9-45e7-978460169b61@blueridgenetworks.com

--===============6541155774290714996==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

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

Ah I missed this. For whatever reason VHT (Very High Throughput) was
not enabled before. This isn't something IWD has a choice over, the AP
controls whether its using HT, VHT, or legacy and as you've seen here
there are other heuristics to determine whether it is used.

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
> -- =

> Bruce Johnson
> Chantilly, Virginia
> OpenPGP key ID: 296D1CD6F2B84CAB https://keys.openpgp.org/
> _______________________________________________
> iwd mailing list -- iwd(a)lists.01.org
> To unsubscribe send an email to iwd-leave(a)lists.01.org


--===============6541155774290714996==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGh0bWw+PGhlYWQ+CgogICAgCiAgPC9oZWFkPgogIDxib2R5PjxkaXY+T24gV2VkLCAyMDIyLTAz
LTA5IGF0IDE1OjU1IC0wNTAwLCBCcnVjZSBBLiBKb2huc29uIHdyb3RlOjwvZGl2PjxibG9ja3F1
b3RlIHR5cGU9ImNpdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDsgYm9yZGVyLWxlZnQ6MnB4
ICM3MjlmY2Ygc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+PHA+RG9lcyBhbnlvbmUgaGF2ZSBhIHJl
Y29tbWVuZGF0aW9uIG9uIGhvdyB0byBvYnRhaW4gdXNhYmxlIGxpbmsgc3BlZWQgaW5mb3JtYXRp
b24gZnJvbSBpd2Q/IE5vdCBmaW5kaW5nIGFueXRoaW5nIGluIHRoZSBBUEksIEkgcmVzb3J0ZWQg
dG8gdGhlIGl3IHRvb2wsIGFuZCB0aGF0IGdhdmUgbWUgdW5iZWxpZXZhYmxlIGluZm9ybWF0aW9u
IGxpa2U6PC9wPjxwcmU+aXcgZGV2IHdsYW4wIGxpbms8L3ByZT48cHJlPkNvbm5lY3RlZCB0byA5
NDphNjo3ZTplMDo5YjoxMCAob24gd2xhbjApPC9wcmU+PHByZT4mbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgU1NJRDogTkVUR0VBUjYyLTVHPC9wcmU+PHByZT4mbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgZnJlcTogNTE4MDwvcHJlPjxw
cmU+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IFJYOiA3MjkyMTg3
MjIgYnl0ZXMgKDY5ODAzNyBwYWNrZXRzKTwvcHJlPjxwcmU+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IFRYOiA2NDk3OTY5NTQgYnl0ZXMgKDU5NzMyNCBwYWNrZXRz
KTwvcHJlPjxwcmU+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IHNp
Z25hbDogLTM2IGRCbTwvcHJlPjxwcmU+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7IHJ4IGJpdHJhdGU6IDI0LjAgTUJpdC9zPC9wcmU+PHByZT4mbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgdHggYml0cmF0ZTogNi4wIE1CaXQvczwvcHJl
PjxwcmU+PGJyPjwvcHJlPjxwcmU+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7IGJzcyBmbGFnczombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgc2hvcnQtc2xv
dC10aW1lPC9wcmU+PHByZT4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsgZHRpbSBwZXJpb2Q6Jm5ic3A7Jm5ic3A7Jm5ic3A7IDE8L3ByZT48cHJlPiZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBiZWFjb24gaW50OiZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyAxMDA8L3ByZT48cD5XaGVuIHRoZSBjb25uZWN0aW9uIHdhcyBpbiB0aGlzIHN0
YXRlLCBJIHdhcyBhYmxlIHRvIHBhc3MgZGF0YSB3aXRoIGlwZXJmMyBhdCBuZWFybHkgMTAwIE1i
cHMgaW4gZWl0aGVyIGRpcmVjdGlvbiB3aXRoIG5vIHBhY2tldCBsb3NzIG9uIHRoZSB0cmFuc21p
dCBhbmQgYWJvdXQgMSUgcGFja2V0IGxvc3Mgb24gdGhlIHJlY2VpdmUuIFdoZW4gSSBtb3ZlZCB0
aGUgcm91dGVyIDEwLTEyIG1ldGVycyBmdXJ0aGVyIGF3YXksIGl3IHJlcG9ydGVkIGEgPHU+aGln
aGVyPC91PiBiaXQgcmF0ZS4gKEkgY291bGRuJ3QgdGVzdCB0aHJvdWdocHV0IGJlY2F1c2UgdGhl
cmUgd2FzIG5vIGNvbm5lY3Rpb24gb24gdGhlIFdBTiBzaWRlIGluIHRoZSBuZXcgbG9jYXRpb24u
KTxicj48L3A+PHByZT4jIGl3IGRldiB3bGFuMCBsaW5rPC9wcmU+PHByZT5Db25uZWN0ZWQgdG8g
OTQ6YTY6N2U6ZTA6OWI6MTAgKG9uIHdsYW4wKTwvcHJlPjxwcmU+Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IFNTSUQ6IE5FVEdFQVI2Mi01RzwvcHJlPjxwcmU+Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGZyZXE6IDUxODA8L3ByZT48
cHJlPiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBSWDogMjQ5NDQg
Ynl0ZXMgKDE3MCBwYWNrZXRzKTwvcHJlPjxwcmU+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7IFRYOiAxOTQ5IGJ5dGVzICgxMiBwYWNrZXRzKTwvcHJlPjxwcmU+Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IHNpZ25hbDogLTY0IGRCbTwv
cHJlPjxwcmU+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IHJ4IGJp
dHJhdGU6IDI2MC4wIE1CaXQvcyBWSFQtTUNTIDMgODBNSHogc2hvcnQgR0kgVkhULU5TUyAyPC9w
cmU+PC9ibG9ja3F1b3RlPjxkaXY+PGJyPjwvZGl2PjxkaXY+QWggSSBtaXNzZWQgdGhpcy4gRm9y
IHdoYXRldmVyIHJlYXNvbiBWSFQgKFZlcnkgSGlnaCBUaHJvdWdocHV0KSB3YXMgbm90IGVuYWJs
ZWQgYmVmb3JlLiBUaGlzIGlzbid0IHNvbWV0aGluZyBJV0QgaGFzIGEgY2hvaWNlIG92ZXIsIHRo
ZSBBUCBjb250cm9scyB3aGV0aGVyIGl0cyB1c2luZyBIVCwgVkhULCBvciBsZWdhY3kgYW5kIGFz
IHlvdSd2ZSBzZWVuIGhlcmUgdGhlcmUgYXJlIG90aGVyIGhldXJpc3RpY3MgdG8gZGV0ZXJtaW5l
IHdoZXRoZXIgaXQgaXMgdXNlZC48L2Rpdj48ZGl2Pjxicj48L2Rpdj48YmxvY2txdW90ZSB0eXBl
PSJjaXRlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7IGJvcmRlci1sZWZ0OjJweCAjNzI5ZmNm
IHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPjxwcmU+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7IHR4IGJpdHJhdGU6IDYuMCBNQml0L3M8L3ByZT48cHJlPjxicj48L3By
ZT48cHJlPiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBic3MgZmxh
Z3M6Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IHNob3J0LXNsb3QtdGltZTwvcHJlPjxw
cmU+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGR0aW0gcGVyaW9k
OiZuYnNwOyZuYnNwOyZuYnNwOyAxPC9wcmU+PHByZT4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsgYmVhY29uIGludDombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgMTAw
PC9wcmU+PHA+SSBtdXN0IGhhdmUgYSBtaXN1bmRlcnN0YW5kaW5nIG9mIHdoYXQgdGhvc2UgZmln
dXJlcyBtZWFuLiBJcyBpdCB0aGF0IHRoZSBvbmx5IHJlYXNvbmFibGUgaW5kaWNhdGlvbiBvZiBs
aW5rIHF1YWxpdHkgaXMgdGhlIHNpZ25hbCBzdHJlbmd0aD88L3A+PHByZT4tLSA8L3ByZT48cHJl
PkJydWNlIEpvaG5zb248L3ByZT48cHJlPkNoYW50aWxseSwgVmlyZ2luaWE8L3ByZT48cHJlPk9w
ZW5QR1Aga2V5IElEOiAyOTZEMUNENkYyQjg0Q0FCIDxhIGNsYXNzPSJtb3otdHh0LWxpbmstZnJl
ZXRleHQiIGhyZWY9Imh0dHBzOi8va2V5cy5vcGVucGdwLm9yZy8iPmh0dHBzOi8va2V5cy5vcGVu
cGdwLm9yZy88L2E+PC9wcmU+PGRpdj5fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXzxicj48L2Rpdj48ZGl2Pml3ZCBtYWlsaW5nIGxpc3QgLS0gPGEgaHJlZj0i
bWFpbHRvOml3ZEBsaXN0cy4wMS5vcmciPml3ZEBsaXN0cy4wMS5vcmc8L2E+PGJyPjwvZGl2Pjxk
aXY+VG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byA8YSBocmVmPSJtYWlsdG86aXdkLWxl
YXZlQGxpc3RzLjAxLm9yZyI+aXdkLWxlYXZlQGxpc3RzLjAxLm9yZzwvYT48YnI+PC9kaXY+PC9i
bG9ja3F1b3RlPjxkaXY+PGJyPjwvZGl2PjxkaXY+PHNwYW4+PC9zcGFuPjwvZGl2PjwvYm9keT48
L2h0bWw+Cg==

--===============6541155774290714996==--

