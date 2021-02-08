Content-Type: multipart/mixed; boundary="===============4336214909943441951=="
MIME-Version: 1.0
From: KeithG <ys3al35l@gmail.com>
Subject: Re: Reconnect issues, still
Date: Mon, 08 Feb 2021 15:32:05 -0600
Message-ID: <CAG17S_NxQzh-0-fEKNmnXzq3S020ng3VG+b0+sePu0n-hAqzOw@mail.gmail.com>
In-Reply-To: <731470a8-d37e-b432-209d-1119e4628912@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4336214909943441951==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 8, 2021 at 1:53 PM Denis Kenzior <denkenz@gmail.com> wrote:

>
> To me, it looks like scanning is being driven over D-Bus by invoking
> Station.Scan().  It also looks like autoconnect has been forced off,
> perhaps via
> Station.Disconnect() being invoked?  Hard to tell from this log, but looks
> iwd
> isn't trying to autoconnect and would instead rely on connman to trigger
> the
> connection.
>
> Regards,
> -Denis
>
Denis,

The /var/lib/iwd/*.psk file has "AutoConnect=3Dtrue" set. I did notice that
last night it had been reset somehow to false after I sent those partial
logs, but I reset it to true today and still do not get a reconnect.

Running the dbus-monitor script shows exactly that. it gets a
{Station} [/net/connman/iwd/0/3] Scanning =3D True
then False periodically, but it never connects. I'll post again on connman
mail list to see what may need to be adjusted.

If I restart iwd, it connects right away.

Regards,
Keith

--===============4336214909943441951==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+T24gTW9uLCBGZWIgOCwgMjAyMSBhdCAxOjUz
IFBNIERlbmlzIEtlbnppb3IgJmx0OzxhIGhyZWY9Im1haWx0bzpkZW5rZW56QGdtYWlsLmNvbSI+
ZGVua2VuekBnbWFpbC5jb208L2E+Jmd0OyB3cm90ZTo8YnI+PC9kaXY+PGRpdiBjbGFzcz0iZ21h
aWxfcXVvdGUiPjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjow
cHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtw
YWRkaW5nLWxlZnQ6MWV4Ij48YnI+ClRvIG1lLCBpdCBsb29rcyBsaWtlIHNjYW5uaW5nIGlzIGJl
aW5nIGRyaXZlbiBvdmVyIEQtQnVzIGJ5IGludm9raW5nIDxicj4KU3RhdGlvbi5TY2FuKCkuwqAg
SXQgYWxzbyBsb29rcyBsaWtlIGF1dG9jb25uZWN0IGhhcyBiZWVuIGZvcmNlZCBvZmYsIHBlcmhh
cHMgdmlhIDxicj4KU3RhdGlvbi5EaXNjb25uZWN0KCkgYmVpbmcgaW52b2tlZD/CoCBIYXJkIHRv
IHRlbGwgZnJvbSB0aGlzIGxvZywgYnV0IGxvb2tzIGl3ZCA8YnI+CmlzbiYjMzk7dCB0cnlpbmcg
dG8gYXV0b2Nvbm5lY3QgYW5kIHdvdWxkIGluc3RlYWQgcmVseSBvbiBjb25ubWFuIHRvIHRyaWdn
ZXIgdGhlIDxicj4KY29ubmVjdGlvbi48YnI+Cjxicj4KUmVnYXJkcyw8YnI+Ci1EZW5pczxicj48
L2Jsb2NrcXVvdGU+PGRpdj5EZW5pcyw8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PlRoZSAvdmFy
L2xpYi9pd2QvKi5wc2sgZmlsZSBoYXMgJnF1b3Q7QXV0b0Nvbm5lY3Q9dHJ1ZSZxdW90OyBzZXQu
IEkgZGlkIG5vdGljZSB0aGF0IGxhc3QgbmlnaHQgaXQgaGFkIGJlZW4gcmVzZXQgc29tZWhvdyB0
byBmYWxzZSBhZnRlciBJIHNlbnQgdGhvc2UgcGFydGlhbCBsb2dzLCBidXQgSSByZXNldCBpdCB0
byB0cnVlIHRvZGF5IGFuZCBzdGlsbCBkbyBub3QgZ2V0IGEgcmVjb25uZWN0Ljxicj48L2Rpdj48
ZGl2Pjxicj48L2Rpdj48ZGl2PlJ1bm5pbmcgdGhlIGRidXMtbW9uaXRvciBzY3JpcHQgc2hvd3Mg
ZXhhY3RseSB0aGF0LiBpdCBnZXRzIGEgPGJyPjwvZGl2PjxkaXY+e1N0YXRpb259IFsvbmV0L2Nv
bm5tYW4vaXdkLzAvM10gU2Nhbm5pbmcgPSBUcnVlIDxicj48L2Rpdj48ZGl2PnRoZW4gRmFsc2Ug
cGVyaW9kaWNhbGx5LCBidXQgaXQgbmV2ZXIgY29ubmVjdHMuIEkmIzM5O2xsIHBvc3QgYWdhaW4g
b24gY29ubm1hbiBtYWlsIGxpc3QgdG8gc2VlIHdoYXQgbWF5IG5lZWQgdG8gYmUgYWRqdXN0ZWQu
PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5JZiBJIHJlc3RhcnQgaXdkLCBpdCBjb25uZWN0cyBy
aWdodCBhd2F5LiA8YnI+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5SZWdhcmRzLDwvZGl2Pjxk
aXY+S2VpdGg8YnI+PC9kaXY+PC9kaXY+PC9kaXY+Cg==

--===============4336214909943441951==--

