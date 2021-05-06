Content-Type: multipart/mixed; boundary="===============7589093594937539225=="
MIME-Version: 1.0
From: Ryan Smith <ryan.smith@density.io>
Subject: Re: [PATCH 2/2] doc: Daemon DBus interface documentation
Date: Thu, 06 May 2021 10:20:03 -0600
Message-ID: <CAM7Wg-UzZFi=TUUoTuNHHroHA2bj8-pZYv9cKTCzSLKXmPZ=+w@mail.gmail.com>
In-Reply-To: <20210505222914.50570-2-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7589093594937539225==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,
Thanks for your work on IWD! There's a typo on the documentation. See
below...

On Wed, May 5, 2021 at 4:29 PM Andrew Zaborowski <
andrew.zaborowski@intel.com> wrote:

> ---
>  doc/daemon-api.txt | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 doc/daemon-api.txt
>
> diff --git a/doc/daemon-api.txt b/doc/daemon-api.txt
> new file mode 100644
> index 00000000..8256bb10
> --- /dev/null
> +++ b/doc/daemon-api.txt
> @@ -0,0 +1,24 @@
> +Daemon hierarchy
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Service                net.connman.iwd
> +Interface      net.connman.iwd.Deamon [Experimental]
>

Should be net.connman.iwd.Daemon


> +Object path    /net/connman/iwd
> +
> +Methods                dict GetInfo()
> +
> +                       Returns basic IWD daemon's status and configurati=
on
> +                       properties.  Their values are global and may be
> useful
> +                       for D-Bus clients interacting with IWD, not so mu=
ch
> +                       for the user.  The returned dictionary (a{sv}) ma=
ps
> +                       string keys to values of types defined per key.
> +                       Clients should ignore unknown keys.
> +
> +                       The following key/value pairs are defined
> currently:
> +
> +                       string Version - IWD release version,
> +
> +                       string StateDirectory - Absolute path to the IWD
> +                       state directory where network configuration and
> +                       runtime state files are kept (see $STATE_DIRECTORY
> in
> +                       iwd(8) and iwd.network(5)).
> --
> 2.27.0
> _______________________________________________
> iwd mailing list -- iwd(a)lists.01.org
> To unsubscribe send an email to iwd-leave(a)lists.01.org


Thanks,
Ryan Smith

--===============7589093594937539225==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGRpdiBkaXI9Imx0ciI+PGRpdj5IaSBBbmRyZXcsPC9kaXY+PGRpdj5UaGFua3MgZm9yIHlvdXIg
d29yayBvbiBJV0QhIFRoZXJlJiMzOTtzIGEgdHlwbyBvbiB0aGUgZG9jdW1lbnRhdGlvbi4gU2Vl
IGJlbG93Li4uPC9kaXY+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj48ZGl2IGRpcj0ibHRy
IiBjbGFzcz0iZ21haWxfYXR0ciI+T24gV2VkLCBNYXkgNSwgMjAyMSBhdCA0OjI5IFBNIEFuZHJl
dyBaYWJvcm93c2tpICZsdDs8YSBocmVmPSJtYWlsdG86YW5kcmV3LnphYm9yb3dza2lAaW50ZWwu
Y29tIiB0YXJnZXQ9Il9ibGFuayI+YW5kcmV3LnphYm9yb3dza2lAaW50ZWwuY29tPC9hPiZndDsg
d3JvdGU6PGJyPjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1h
cmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQs
MjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij4tLS08YnI+CsKgZG9jL2RhZW1vbi1hcGkudHh0IHwgMjQg
KysrKysrKysrKysrKysrKysrKysrKysrPGJyPgrCoDEgZmlsZSBjaGFuZ2VkLCAyNCBpbnNlcnRp
b25zKCspPGJyPgrCoGNyZWF0ZSBtb2RlIDEwMDY0NCBkb2MvZGFlbW9uLWFwaS50eHQ8YnI+Cjxi
cj4KZGlmZiAtLWdpdCBhL2RvYy9kYWVtb24tYXBpLnR4dCBiL2RvYy9kYWVtb24tYXBpLnR4dDxi
cj4KbmV3IGZpbGUgbW9kZSAxMDA2NDQ8YnI+CmluZGV4IDAwMDAwMDAwLi44MjU2YmIxMDxicj4K
LS0tIC9kZXYvbnVsbDxicj4KKysrIGIvZG9jL2RhZW1vbi1hcGkudHh0PGJyPgpAQCAtMCwwICsx
LDI0IEBAPGJyPgorRGFlbW9uIGhpZXJhcmNoeTxicj4KKz09PT09PT09PT09PT09PT08YnI+Cis8
YnI+CitTZXJ2aWNlwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgbmV0LmNvbm5tYW4uaXdkPGJyPgor
SW50ZXJmYWNlwqAgwqAgwqAgbmV0LmNvbm5tYW4uaXdkLkRlYW1vbiBbRXhwZXJpbWVudGFsXTxi
cj48L2Jsb2NrcXVvdGU+PGRpdj48YnI+PC9kaXY+PGRpdj5TaG91bGQgYmUgbmV0LmNvbm5tYW4u
aXdkLkRhZW1vbjwvZGl2PjxkaXY+wqA8L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVv
dGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlk
IHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+CitPYmplY3QgcGF0aMKgIMKgIC9u
ZXQvY29ubm1hbi9pd2Q8YnI+Cis8YnI+CitNZXRob2RzwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
ZGljdCBHZXRJbmZvKCk8YnI+Cis8YnI+CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoFJldHVybnMgYmFzaWMgSVdEIGRhZW1vbiYjMzk7cyBzdGF0dXMgYW5kIGNvbmZpZ3VyYXRp
b248YnI+CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHByb3BlcnRpZXMuwqAg
VGhlaXIgdmFsdWVzIGFyZSBnbG9iYWwgYW5kIG1heSBiZSB1c2VmdWw8YnI+CivCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGZvciBELUJ1cyBjbGllbnRzIGludGVyYWN0aW5nIHdp
dGggSVdELCBub3Qgc28gbXVjaDxicj4KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgZm9yIHRoZSB1c2VyLsKgIFRoZSByZXR1cm5lZCBkaWN0aW9uYXJ5IChhe3N2fSkgbWFwczxi
cj4KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc3RyaW5nIGtleXMgdG8gdmFs
dWVzIG9mIHR5cGVzIGRlZmluZWQgcGVyIGtleS48YnI+CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoENsaWVudHMgc2hvdWxkIGlnbm9yZSB1bmtub3duIGtleXMuPGJyPgorPGJy
PgorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBUaGUgZm9sbG93aW5nIGtleS92
YWx1ZSBwYWlycyBhcmUgZGVmaW5lZCBjdXJyZW50bHk6PGJyPgorPGJyPgorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzdHJpbmcgVmVyc2lvbiAtIElXRCByZWxlYXNlIHZlcnNp
b24sPGJyPgorPGJyPgorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzdHJpbmcg
U3RhdGVEaXJlY3RvcnkgLSBBYnNvbHV0ZSBwYXRoIHRvIHRoZSBJV0Q8YnI+CivCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN0YXRlIGRpcmVjdG9yeSB3aGVyZSBuZXR3b3JrIGNv
bmZpZ3VyYXRpb24gYW5kPGJyPgorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBy
dW50aW1lIHN0YXRlIGZpbGVzIGFyZSBrZXB0IChzZWUgJFNUQVRFX0RJUkVDVE9SWSBpbjxicj4K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaXdkKDgpIGFuZCBpd2QubmV0d29y
ayg1KSkuPGJyPgotLSA8YnI+CjIuMjcuMDxicj4KX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX188YnI+Cml3ZCBtYWlsaW5nIGxpc3QgLS0gPGEgaHJlZj0ibWFp
bHRvOml3ZEBsaXN0cy4wMS5vcmciIHRhcmdldD0iX2JsYW5rIj5pd2RAbGlzdHMuMDEub3JnPC9h
Pjxicj4KVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byA8YSBocmVmPSJtYWlsdG86aXdk
LWxlYXZlQGxpc3RzLjAxLm9yZyIgdGFyZ2V0PSJfYmxhbmsiPml3ZC1sZWF2ZUBsaXN0cy4wMS5v
cmc8L2E+PC9ibG9ja3F1b3RlPjxkaXY+PGJyPjwvZGl2PjxkaXY+VGhhbmtzLDwvZGl2PjxkaXY+
UnlhbiBTbWl0aMKgPC9kaXY+PC9kaXY+PC9kaXY+Cg==

--===============7589093594937539225==--

