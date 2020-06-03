Content-Type: multipart/mixed; boundary="===============1116924067208987401=="
MIME-Version: 1.0
From: KeithG <ys3al35l@gmail.com>
Subject: Re: Cannot get ap mode to work
Date: Wed, 03 Jun 2020 14:12:06 -0500
Message-ID: <CAG17S_NBO7mWaCo2kyVd77=kEYP_hM7JWCHw8ZGK3cbH6QHu0A@mail.gmail.com>
In-Reply-To: <11473749-6da8-4431-95aa-799a633867ae@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1116924067208987401==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Tim,

Good call, but same result.

It is interesting that in this mode that the interface has no IP address. I
would think that it would have something there:

# ip addr
...
3: wlan0: <NO-CARRIER,BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc
fq_codel state DORMANT group default qlen 1000 link/ether b8:27:eb:52:cc:d0
brd ff:ff:ff:ff:ff:ff

When I use dnsmasq/hostapd, it lists its IP address before a connection
attempt is made.

On Wed, Jun 3, 2020 at 1:19 PM Kourt, Tim A <tim.a.kourt@linux.intel.com>
wrote:

> Hi Keith,
>
> On 6/3/2020 10:17 AM, KeithG wrote:
> >
> > ~# iwctl device wlan0 show
> >                                  Device: wlan0
> >
> -------------------------------------------------------------------------=
-------
> >   Settable  Property            Value
> >
> -------------------------------------------------------------------------=
-------
> >             Name                wlan0
> >          *  Mode                ap
> >          *  Powered             on
> >             Address             b8:27:eb:52:cc:d0
> >             Adapter             phy0
> >
> > ~# iwctl ap wlan0 start "MyNet" "password"
> >
> If the quotes are not part of the password, try to remove them.
>
> Regards,
> Tim
>
>

--===============1116924067208987401==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGRpdiBkaXI9Imx0ciI+PGRpdj5UaW0sPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5Hb29kIGNh
bGwsIGJ1dCBzYW1lIHJlc3VsdC4gPGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+SXQgaXMg
aW50ZXJlc3RpbmcgdGhhdCBpbiB0aGlzIG1vZGUgdGhhdCB0aGUgaW50ZXJmYWNlIGhhcyBubyBJ
UCBhZGRyZXNzLiBJIHdvdWxkIHRoaW5rIHRoYXQgaXQgd291bGQgaGF2ZSBzb21ldGhpbmcgdGhl
cmU6PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48c3BhbiBzdHlsZT0iZm9udC1mYW1pbHk6bW9u
b3NwYWNlIj4jIGlwIGFkZHI8L3NwYW4+PC9kaXY+PGRpdj48c3BhbiBzdHlsZT0iZm9udC1mYW1p
bHk6bW9ub3NwYWNlIj4uLi48YnI+PC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9ImZvbnQt
ZmFtaWx5Om1vbm9zcGFjZSI+Mzogd2xhbjA6ICZsdDtOTy1DQVJSSUVSLEJST0FEQ0FTVCxNVUxU
SUNBU1QsVVAsTE9XRVJfVVAmZ3Q7IG10dSAxNTAwIHFkaXNjIGZxX2NvZGVsIHN0YXRlIERPUk1B
TlQgZ3JvdXAgZGVmYXVsdCBxbGVuIDEwMDAgbGluay9ldGhlciBiODoyNzplYjo1MjpjYzpkMCBi
cmQgZmY6ZmY6ZmY6ZmY6ZmY6ZmY8L3NwYW4+PC9kaXY+PGRpdj48c3BhbiBzdHlsZT0iZm9udC1m
YW1pbHk6bW9ub3NwYWNlIj48YnI+PC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9ImZvbnQt
ZmFtaWx5Om1vbm9zcGFjZSI+PGZvbnQgZmFjZT0iYXJpYWwsc2Fucy1zZXJpZiI+V2hlbiBJIHVz
ZSBkbnNtYXNxL2hvc3RhcGQsIGl0IGxpc3RzIGl0cyBJUCBhZGRyZXNzIGJlZm9yZSBhIGNvbm5l
Y3Rpb24gYXR0ZW1wdCBpcyBtYWRlLjwvZm9udD48L3NwYW4+PGJyPjwvZGl2PjwvZGl2Pjxicj48
ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGRpdiBkaXI9Imx0ciIgY2xhc3M9ImdtYWlsX2F0dHIi
Pk9uIFdlZCwgSnVuIDMsIDIwMjAgYXQgMToxOSBQTSBLb3VydCwgVGltIEEgJmx0OzxhIGhyZWY9
Im1haWx0bzp0aW0uYS5rb3VydEBsaW51eC5pbnRlbC5jb20iPnRpbS5hLmtvdXJ0QGxpbnV4Lmlu
dGVsLmNvbTwvYT4mZ3Q7IHdyb3RlOjxicj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxf
cXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNv
bGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+SGkgS2VpdGgsPGJyPgo8YnI+
Ck9uIDYvMy8yMDIwIDEwOjE3IEFNLCBLZWl0aEcgd3JvdGU6PGJyPgomZ3Q7PGJyPgomZ3Q7IH4j
IGl3Y3RsIGRldmljZSB3bGFuMCBzaG93PGJyPgomZ3Q7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgRGV2aWNlOiB3bGFuMDxicj4KJmd0OyAtLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLTxicj4KJmd0OyDCoCBTZXR0YWJsZSDCoFByb3BlcnR5IMKgIMKgIMKg
IMKgIMKgIMKgVmFsdWU8YnI+CiZndDsgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS08YnI+CiZndDsg
wqAgwqAgwqAgwqAgwqAgwqAgTmFtZSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHdsYW4wPGJyPgom
Z3Q7IMKgIMKgIMKgIMKgIMKgKiDCoE1vZGUgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBhcDxicj4K
Jmd0OyDCoCDCoCDCoCDCoCDCoCogwqBQb3dlcmVkIMKgIMKgIMKgIMKgIMKgIMKgIG9uPGJyPgom
Z3Q7IMKgIMKgIMKgIMKgIMKgIMKgIEFkZHJlc3MgwqAgwqAgwqAgwqAgwqAgwqAgYjg6Mjc6ZWI6
NTI6Y2M6ZDA8YnI+CiZndDsgwqAgwqAgwqAgwqAgwqAgwqAgQWRhcHRlciDCoCDCoCDCoCDCoCDC
oCDCoCBwaHkwPGJyPgomZ3Q7PGJyPgomZ3Q7IH4jIGl3Y3RsIGFwIHdsYW4wIHN0YXJ0ICZxdW90
O015TmV0JnF1b3Q7ICZxdW90O3Bhc3N3b3JkJnF1b3Q7PGJyPgomZ3Q7PGJyPgpJZiB0aGUgcXVv
dGVzIGFyZSBub3QgcGFydCBvZiB0aGUgcGFzc3dvcmQsIHRyeSB0byByZW1vdmUgdGhlbS48YnI+
Cjxicj4KUmVnYXJkcyw8YnI+ClRpbTxicj4KPGJyPgo8L2Jsb2NrcXVvdGU+PC9kaXY+Cg==

--===============1116924067208987401==--

