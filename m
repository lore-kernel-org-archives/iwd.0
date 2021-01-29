Content-Type: multipart/mixed; boundary="===============4655193822328380112=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: Re: broadcom fmac ap mode testing - how to set iwd as dhcp server?
Date: Thu, 28 Jan 2021 17:37:00 -0800
Message-ID: <c8c2dfe5bed4a02bade21f0a12cf71f0da2c97ca.camel@gmail.com>
In-Reply-To: <CAG17S_NPTw0uyaygZ1FWHm9ar6KCMMr57iVY0apAN-ejeNc+Ew@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4655193822328380112==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Keith,

<snip>
>  When I restart the AP from iwct, I can connect again. =

> What I do not yet know how to do, though, is assign an ip address to
> the ap and then have it be a dhcp server to serve out a dhcp address
> to the connecting computer. I found this online and took a stab, but
> it did not assign an address, though the computer did 'attach'.

Yes this is exactly the behavior we are seeing as well. I do have a
patch which fixes the disconnect issue and allows the same client to
connect again but we've actually got more problems than this. My recent
patches 'fixing' AP mode is somewhat of a hack in all honesty. It
allows the 4-way handshake to happen but not the GTK handshake. This
means no group traffic which breaks DHCP.

I won't bore you with details but it boils down to brcmfmac being (as
far as we can tell) broken when used this way. We are going to
investigate handshake offloading which might fix it, but we just don't
know yet. I am expecting offloading to work  but if not we need to talk
with linux-wireless/broadcom about why its broken or how it supposed to
work. Anyways, we hope to have this sorted soon.

FYI even hostapd exibits this exact same behavior with brcmfmac cards,
does the 4-way but no GTK handshake. At least on my brcmfmac cards. I
would be curious if it does the same for you.

> How do you set it up for iwd to be a dhcp server? If iwd cannot do
> it, can I use dhcpd? dnsmasq? I have found very little info in my
> searches. =


You're likely setting it up correctly (EnableNetworkConfiguration=3Dtrue)
but we've got this GTK problem.

Thanks,
James

--===============4655193822328380112==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGh0bWwgZGlyPSJsdHIiPjxoZWFkPjwvaGVhZD48Ym9keSBzdHlsZT0idGV4dC1hbGlnbjpsZWZ0
OyBkaXJlY3Rpb246bHRyOyI+PGRpdj5IaSBLZWl0aCw8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2
PiZsdDtzbmlwJmd0OzwvZGl2PjxibG9ja3F1b3RlIHR5cGU9ImNpdGUiIHN0eWxlPSJtYXJnaW46
MCAwIDAgLjhleDsgYm9yZGVyLWxlZnQ6MnB4ICM3MjlmY2Ygc29saWQ7cGFkZGluZy1sZWZ0OjFl
eCI+PGRpdiBkaXI9Imx0ciI+PGRpdj48YnI+PC9kaXY+PGRpdj4gV2hlbiBJIHJlc3RhcnQgdGhl
IEFQIGZyb20gaXdjdCwgSSBjYW4gY29ubmVjdCBhZ2Fpbi4gPGJyPjwvZGl2PjxkaXY+V2hhdCBJ
IGRvIG5vdCB5ZXQga25vdyBob3cgdG8gZG8sIHRob3VnaCwgaXMgYXNzaWduIGFuIGlwIGFkZHJl
c3MgdG8gdGhlIGFwIGFuZCB0aGVuIGhhdmUgaXQgYmUgYSBkaGNwIHNlcnZlciB0byBzZXJ2ZSBv
dXQgYSBkaGNwIGFkZHJlc3MgdG8gdGhlIGNvbm5lY3RpbmcgY29tcHV0ZXIuIEkgZm91bmQgdGhp
cyBvbmxpbmUgYW5kIHRvb2sgYSBzdGFiLCBidXQgaXQgZGlkIG5vdCBhc3NpZ24gYW4gYWRkcmVz
cywgdGhvdWdoIHRoZSBjb21wdXRlciBkaWQgJ2F0dGFjaCcuPC9kaXY+PC9kaXY+PC9ibG9ja3F1
b3RlPjxkaXY+PGJyPjwvZGl2PjxkaXY+WWVzIHRoaXMgaXMgZXhhY3RseSB0aGUgYmVoYXZpb3Ig
d2UgYXJlIHNlZWluZyBhcyB3ZWxsLiBJIGRvIGhhdmUgYSBwYXRjaCB3aGljaCBmaXhlcyB0aGUg
ZGlzY29ubmVjdCBpc3N1ZSBhbmQgYWxsb3dzIHRoZSBzYW1lIGNsaWVudCB0byBjb25uZWN0IGFn
YWluIGJ1dCB3ZSd2ZSBhY3R1YWxseSBnb3QgbW9yZSBwcm9ibGVtcyB0aGFuIHRoaXMuIE15IHJl
Y2VudCBwYXRjaGVzICdmaXhpbmcnIEFQIG1vZGUgaXMgc29tZXdoYXQgb2YgYSBoYWNrIGluIGFs
bCBob25lc3R5LiBJdCBhbGxvd3MgdGhlIDQtd2F5IGhhbmRzaGFrZSB0byBoYXBwZW4gYnV0IG5v
dCB0aGUgR1RLIGhhbmRzaGFrZS4gVGhpcyBtZWFucyBubyBncm91cCB0cmFmZmljIHdoaWNoIGJy
ZWFrcyBESENQLjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+SSB3b24ndCBib3JlIHlvdSB3aXRo
IGRldGFpbHMgYnV0IGl0IGJvaWxzIGRvd24gdG8gYnJjbWZtYWMgYmVpbmcgKGFzIGZhciBhcyB3
ZSBjYW4gdGVsbCkgYnJva2VuIHdoZW4gdXNlZCB0aGlzIHdheS4gV2UgYXJlIGdvaW5nIHRvIGlu
dmVzdGlnYXRlIGhhbmRzaGFrZSBvZmZsb2FkaW5nIHdoaWNoIG1pZ2h0IGZpeCBpdCwgYnV0IHdl
IGp1c3QgZG9uJ3Qga25vdyB5ZXQuIEkgYW0gZXhwZWN0aW5nIG9mZmxvYWRpbmcgdG8gd29yayAm
bmJzcDtidXQgaWYgbm90IHdlIG5lZWQgdG8gdGFsayB3aXRoIGxpbnV4LXdpcmVsZXNzL2Jyb2Fk
Y29tIGFib3V0IHdoeSBpdHMgYnJva2VuIG9yIGhvdyBpdCBzdXBwb3NlZCB0byB3b3JrLiBBbnl3
YXlzLCB3ZSBob3BlIHRvIGhhdmUgdGhpcyBzb3J0ZWQgc29vbi48L2Rpdj48ZGl2Pjxicj48L2Rp
dj48ZGl2PkZZSSBldmVuIGhvc3RhcGQgZXhpYml0cyB0aGlzIGV4YWN0IHNhbWUgYmVoYXZpb3Ig
d2l0aCBicmNtZm1hYyBjYXJkcywgZG9lcyB0aGUgNC13YXkgYnV0IG5vIEdUSyBoYW5kc2hha2Uu
IEF0IGxlYXN0IG9uIG15IGJyY21mbWFjIGNhcmRzLiBJIHdvdWxkIGJlIGN1cmlvdXMgaWYgaXQg
ZG9lcyB0aGUgc2FtZSBmb3IgeW91LjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxibG9ja3F1b3RlIHR5
cGU9ImNpdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDsgYm9yZGVyLWxlZnQ6MnB4ICM3Mjlm
Y2Ygc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+PGRpdiBkaXI9Imx0ciI+PGRpdj5Ib3cgZG8geW91
IHNldCBpdCB1cCBmb3IgaXdkIHRvIGJlIGEgZGhjcCBzZXJ2ZXI/IElmIGl3ZCBjYW5ub3QgZG8g
aXQsIGNhbiBJIHVzZSBkaGNwZD8gZG5zbWFzcT8gSSBoYXZlIGZvdW5kIHZlcnkgbGl0dGxlIGlu
Zm8gaW4gbXkgc2VhcmNoZXMuIDxicj48L2Rpdj48L2Rpdj48L2Jsb2NrcXVvdGU+PGRpdj48YnI+
PC9kaXY+PGRpdj5Zb3UncmUgbGlrZWx5IHNldHRpbmcgaXQgdXAgY29ycmVjdGx5IChFbmFibGVO
ZXR3b3JrQ29uZmlndXJhdGlvbj10cnVlKSBidXQgd2UndmUgZ290IHRoaXMgR1RLIHByb2JsZW0u
PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5UaGFua3MsPC9kaXY+PGRpdj5KYW1lczwvZGl2Pjwv
Ym9keT48L2h0bWw+Cg==

--===============4655193822328380112==--

