Content-Type: multipart/mixed; boundary="===============7609973664065594636=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: Re: [PATCH 6/6] station: disable roaming logic for auto-roaming cards
Date: Wed, 10 Mar 2021 13:15:11 -0800
Message-ID: <06fb951fa51a52fe564573044d38156018873b51.camel@gmail.com>
In-Reply-To: <03070558-c7ae-24f2-d4a3-ce5f9f401dd3@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7609973664065594636==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2021-03-10 at 15:01 -0600, Denis Kenzior wrote:
> Hi James,
> =

> On 3/10/21 2:27 PM, James Prestwood wrote:
> > If the hardware roams automatically we want to be sure to not
> > react to CQM events and attempt to roam/disconnect on our own.
> > =

> > Note: this is only important for very new kernels where CQM
> > events were recently added to brcmfmac.
> > ---
> >   src/station.c | 8 ++++++++
> >   1 file changed, 8 insertions(+)
> > =

> > diff --git a/src/station.c b/src/station.c
> > index f9fa0d71..fd985a1b 100644
> > --- a/src/station.c
> > +++ b/src/station.c
> > @@ -2170,6 +2170,14 @@ static bool station_cannot_roam(struct
> > station *station)
> >   	const struct l_settings *config =3D iwd_get_config();
> >   	bool disabled;
> >   =

> > +	/*
> > +	 * Disable roaming with hardware that can roam automatically.
> > Note this
> > +	 * is now required for recent kernels which have CQM event
> > support on
> > +	 * this type of hardware (e.g. brcmfmac).
> > +	 */
> > +	if (wiphy_supports_fw_roam(station->wiphy))
> > +		return true;
> > +
> =

> Hmm, isn't this completely opposite to the intent of adding this
> capability to =

> brcmfmac?

Unless there is a way to disable FW roaming we cannot allow station to
roam based on CQM events. We don't have any control when the FW roams
so for cards like this I figured it was needed to disable this roaming
logic.

I've only tested this on my single brcmfmac card, which definitely will
not work right if station reacts to CQM events. Plus station cannot
even do FT on these cards anyways.

Maybe Alvin has some insight to this?

> >   	if (!l_settings_get_bool(config, "Scan", "DisableRoamingScan",
> >   								&disabl
> > ed))
> >   		disabled =3D false;
> > =

> =

> Regards,
> -Denis

Thanks,
James

--===============7609973664065594636==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGh0bWwgZGlyPSJsdHIiPjxoZWFkPjwvaGVhZD48Ym9keSBzdHlsZT0idGV4dC1hbGlnbjpsZWZ0
OyBkaXJlY3Rpb246bHRyOyI+PGRpdj5PbiBXZWQsIDIwMjEtMDMtMTAgYXQgMTU6MDEgLTA2MDAs
IERlbmlzIEtlbnppb3Igd3JvdGU6PC9kaXY+PGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSIgc3R5bGU9
Im1hcmdpbjowIDAgMCAuOGV4OyBib3JkZXItbGVmdDoycHggIzcyOWZjZiBzb2xpZDtwYWRkaW5n
LWxlZnQ6MWV4Ij48ZGl2PkhpIEphbWVzLDwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+T24gMy8x
MC8yMSAyOjI3IFBNLCBKYW1lcyBQcmVzdHdvb2Qgd3JvdGU6PC9kaXY+PGJsb2NrcXVvdGUgdHlw
ZT0iY2l0ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4OyBib3JkZXItbGVmdDoycHggIzcyOWZj
ZiBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij48ZGl2PklmIHRoZSBoYXJkd2FyZSByb2FtcyBhdXRv
bWF0aWNhbGx5IHdlIHdhbnQgdG8gYmUgc3VyZSB0byBub3Q8L2Rpdj48ZGl2PnJlYWN0IHRvIENR
TSBldmVudHMgYW5kIGF0dGVtcHQgdG8gcm9hbS9kaXNjb25uZWN0IG9uIG91ciBvd24uPC9kaXY+
PGRpdj48YnI+PC9kaXY+PGRpdj5Ob3RlOiB0aGlzIGlzIG9ubHkgaW1wb3J0YW50IGZvciB2ZXJ5
IG5ldyBrZXJuZWxzIHdoZXJlIENRTTwvZGl2PjxkaXY+ZXZlbnRzIHdlcmUgcmVjZW50bHkgYWRk
ZWQgdG8gYnJjbWZtYWMuPC9kaXY+PGRpdj4tLS08L2Rpdj48ZGl2PiZuYnNwOyBzcmMvc3RhdGlv
bi5jIHwgOCArKysrKysrKzwvZGl2PjxkaXY+Jm5ic3A7IDEgZmlsZSBjaGFuZ2VkLCA4IGluc2Vy
dGlvbnMoKyk8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PmRpZmYgLS1naXQgYS9zcmMvc3RhdGlv
bi5jIGIvc3JjL3N0YXRpb24uYzwvZGl2PjxkaXY+aW5kZXggZjlmYTBkNzEuLmZkOTg1YTFiIDEw
MDY0NDwvZGl2PjxkaXY+LS0tIGEvc3JjL3N0YXRpb24uYzwvZGl2PjxkaXY+KysrIGIvc3JjL3N0
YXRpb24uYzwvZGl2PjxkaXY+QEAgLTIxNzAsNiArMjE3MCwxNCBAQCBzdGF0aWMgYm9vbCBzdGF0
aW9uX2Nhbm5vdF9yb2FtKHN0cnVjdCBzdGF0aW9uICpzdGF0aW9uKTwvZGl2PjxkaXY+Jm5ic3A7
Jm5ic3A7CWNvbnN0IHN0cnVjdCBsX3NldHRpbmdzICpjb25maWcgPSBpd2RfZ2V0X2NvbmZpZygp
OzwvZGl2PjxkaXY+Jm5ic3A7Jm5ic3A7CWJvb2wgZGlzYWJsZWQ7PC9kaXY+PGRpdj4mbmJzcDsm
bmJzcDs8L2Rpdj48ZGl2PisJLyo8L2Rpdj48ZGl2PisJJm5ic3A7KiBEaXNhYmxlIHJvYW1pbmcg
d2l0aCBoYXJkd2FyZSB0aGF0IGNhbiByb2FtIGF1dG9tYXRpY2FsbHkuIE5vdGUgdGhpczwvZGl2
PjxkaXY+KwkmbmJzcDsqIGlzIG5vdyByZXF1aXJlZCBmb3IgcmVjZW50IGtlcm5lbHMgd2hpY2gg
aGF2ZSBDUU0gZXZlbnQgc3VwcG9ydCBvbjwvZGl2PjxkaXY+KwkmbmJzcDsqIHRoaXMgdHlwZSBv
ZiBoYXJkd2FyZSAoZS5nLiBicmNtZm1hYykuPC9kaXY+PGRpdj4rCSZuYnNwOyovPC9kaXY+PGRp
dj4rCWlmICh3aXBoeV9zdXBwb3J0c19md19yb2FtKHN0YXRpb24tJmd0O3dpcGh5KSk8L2Rpdj48
ZGl2PisJCXJldHVybiB0cnVlOzwvZGl2PjxkaXY+KzwvZGl2PjwvYmxvY2txdW90ZT48ZGl2Pjxi
cj48L2Rpdj48ZGl2PkhtbSwgaXNuJ3QgdGhpcyBjb21wbGV0ZWx5IG9wcG9zaXRlIHRvIHRoZSBp
bnRlbnQgb2YgYWRkaW5nIHRoaXMgY2FwYWJpbGl0eSB0byZuYnNwOzwvZGl2PjxkaXY+YnJjbWZt
YWM/PC9kaXY+PC9ibG9ja3F1b3RlPjxkaXY+PGJyPjwvZGl2PjxkaXY+VW5sZXNzIHRoZXJlIGlz
IGEgd2F5IHRvIGRpc2FibGUgRlcgcm9hbWluZyB3ZSBjYW5ub3QgYWxsb3cgc3RhdGlvbiB0byBy
b2FtIGJhc2VkIG9uIENRTSBldmVudHMuIFdlIGRvbid0IGhhdmUgYW55IGNvbnRyb2wgd2hlbiB0
aGUgRlcgcm9hbXMgc28gZm9yIGNhcmRzIGxpa2UgdGhpcyBJIGZpZ3VyZWQgaXQgd2FzIG5lZWRl
ZCB0byBkaXNhYmxlIHRoaXMgcm9hbWluZyBsb2dpYy48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2
PkkndmUgb25seSB0ZXN0ZWQgdGhpcyBvbiBteSBzaW5nbGUgYnJjbWZtYWMgY2FyZCwgd2hpY2gg
ZGVmaW5pdGVseSB3aWxsIG5vdCB3b3JrIHJpZ2h0IGlmIHN0YXRpb24gcmVhY3RzIHRvIENRTSBl
dmVudHMuIFBsdXMgc3RhdGlvbiBjYW5ub3QgZXZlbiBkbyBGVCBvbiB0aGVzZSBjYXJkcyBhbnl3
YXlzLjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+TWF5YmUgQWx2aW4gaGFzIHNvbWUgaW5zaWdo
dCB0byB0aGlzPzwvZGl2PjxkaXY+PGJyPjwvZGl2PjxibG9ja3F1b3RlIHR5cGU9ImNpdGUiIHN0
eWxlPSJtYXJnaW46MCAwIDAgLjhleDsgYm9yZGVyLWxlZnQ6MnB4ICM3MjlmY2Ygc29saWQ7cGFk
ZGluZy1sZWZ0OjFleCI+PGRpdj48YnI+PC9kaXY+PGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSIgc3R5
bGU9Im1hcmdpbjowIDAgMCAuOGV4OyBib3JkZXItbGVmdDoycHggIzcyOWZjZiBzb2xpZDtwYWRk
aW5nLWxlZnQ6MWV4Ij48ZGl2PiZuYnNwOyZuYnNwOwlpZiAoIWxfc2V0dGluZ3NfZ2V0X2Jvb2wo
Y29uZmlnLCAiU2NhbiIsICJEaXNhYmxlUm9hbWluZ1NjYW4iLDwvZGl2PjxkaXY+Jm5ic3A7Jm5i
c3A7CQkJCQkJCQkmYW1wO2Rpc2FibGVkKSk8L2Rpdj48ZGl2PiZuYnNwOyZuYnNwOwkJZGlzYWJs
ZWQgPSBmYWxzZTs8L2Rpdj48ZGl2Pjxicj48L2Rpdj48L2Jsb2NrcXVvdGU+PGRpdj48YnI+PC9k
aXY+PGRpdj5SZWdhcmRzLDwvZGl2PjxkaXY+LURlbmlzPC9kaXY+PC9ibG9ja3F1b3RlPjxkaXY+
PGJyPjwvZGl2PjxkaXY+VGhhbmtzLDwvZGl2PjxkaXY+SmFtZXM8L2Rpdj48L2JvZHk+PC9odG1s
Pgo=

--===============7609973664065594636==--

