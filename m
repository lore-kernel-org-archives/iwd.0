Content-Type: multipart/mixed; boundary="===============5982303572841136435=="
MIME-Version: 1.0
From: Khem Raj <raj.khem@gmail.com>
Subject: Re: [PATCH] Makefile.am: Avoid redirection of input and output files
Date: Tue, 05 Nov 2019 05:37:48 -0800
Message-ID: <CAMKF1srR9fs6N+5rmKxyDTXNPB3ewW2N-2rFa-gv1a3V0eaT-w@mail.gmail.com>
In-Reply-To: <F316B322-020B-4D7A-BF10-8EF7B5CB7CE2@holtmann.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5982303572841136435==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2019 at 10:11 PM Marcel Holtmann <marcel@holtmann.org> wro=
te:

> Hi Khem,
>
> > This can cause a build race in a highly parallelised build where a
> directory is not yet created but
> > output file is being written using redirection e.g.
> >
> > rst2man.py --strict --no-raw --no-generator --no-datestamp <
> ../git/monitor/iwmon.rst > monitor/iwmon.1
> > /bin/sh: monitor/iwmon.1: No such file or directory
> > make[1]: *** [Makefile:3544: monitor/iwmon.1] Error 1
> > ---
> > Makefile.am | 8 ++++----
> > 1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/Makefile.am b/Makefile.am
> > index 823b7d02..21dd707c 100644
> > --- a/Makefile.am
> > +++ b/Makefile.am
> > @@ -627,7 +627,7 @@ SED_PROCESS =3D $(AM_V_GEN)$(MKDIR_P) $(dir $@) &&
> $(SED) \
> >
> > if RUN_RST2MAN
> > RST2MAN_PROCESS =3D $(AM_V_GEN)$(RST2MAN) --strict --no-raw --no-genera=
tor
> \
> > -                     --no-datestamp < $< > $@
> > +                     --no-datestamp
> > else
> > RST2MAN_PROCESS =3D $(AM_V_GEN)test -f $@ || \
> >               { echo "Generated manual page $@ does not exist"; false; }
>
> so this is bad in case the else clause is used.
>
> > @@ -637,13 +637,13 @@ endif
> >       $(SED_PROCESS)
> >
> > %.1: %.rst Makefile
> > -     $(RST2MAN_PROCESS)
> > +     $(RST2MAN_PROCESS) $< $@
> >
> > %.5: %.rst Makefile
> > -     $(RST2MAN_PROCESS)
> > +     $(RST2MAN_PROCESS) $< $@
> >
> > %.8: %.rst Makefile
> > -     $(RST2MAN_PROCESS)
> > +     $(RST2MAN_PROCESS) $< $@
>
> Is adding this to the RST2MAN_PROCESS variable not working?


I think that will work fine I just moved it here for
Convenience I can move it back I think real race is that directory is not
created before a file inside the directory is being redirected to. This
happens when doing out of tree build so the directory is not pre existing

>
>
> Regards
>
> Marcel
>
>

--===============5982303572841136435==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdj48YnI+PC9kaXY+PGRpdj48YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPjxkaXYgZGly
PSJsdHIiIGNsYXNzPSJnbWFpbF9hdHRyIj5PbiBNb24sIE5vdiA0LCAyMDE5IGF0IDEwOjExIFBN
IE1hcmNlbCBIb2x0bWFubiAmbHQ7PGEgaHJlZj0ibWFpbHRvOm1hcmNlbEBob2x0bWFubi5vcmci
Pm1hcmNlbEBob2x0bWFubi5vcmc8L2E+Jmd0OyB3cm90ZTo8YnI+PC9kaXY+PGJsb2NrcXVvdGUg
Y2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6
MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+SGkgS2hlbSw8YnI+Cjxicj4KJmd0OyBU
aGlzIGNhbiBjYXVzZSBhIGJ1aWxkIHJhY2UgaW4gYSBoaWdobHkgcGFyYWxsZWxpc2VkIGJ1aWxk
IHdoZXJlIGEgZGlyZWN0b3J5IGlzIG5vdCB5ZXQgY3JlYXRlZCBidXQ8YnI+CiZndDsgb3V0cHV0
IGZpbGUgaXMgYmVpbmcgd3JpdHRlbiB1c2luZyByZWRpcmVjdGlvbiBlLmcuPGJyPgomZ3Q7IDxi
cj4KJmd0OyByc3QybWFuLnB5IC0tc3RyaWN0IC0tbm8tcmF3IC0tbm8tZ2VuZXJhdG9yIC0tbm8t
ZGF0ZXN0YW1wICZsdDsgLi4vZ2l0L21vbml0b3IvaXdtb24ucnN0ICZndDsgbW9uaXRvci9pd21v
bi4xPGJyPgomZ3Q7IC9iaW4vc2g6IG1vbml0b3IvaXdtb24uMTogTm8gc3VjaCBmaWxlIG9yIGRp
cmVjdG9yeTxicj4KJmd0OyBtYWtlWzFdOiAqKiogW01ha2VmaWxlOjM1NDQ6IG1vbml0b3IvaXdt
b24uMV0gRXJyb3IgMTxicj4KJmd0OyAtLS08YnI+CiZndDsgTWFrZWZpbGUuYW0gfCA4ICsrKyst
LS0tPGJyPgomZ3Q7IDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25z
KC0pPGJyPgomZ3Q7IDxicj4KJmd0OyBkaWZmIC0tZ2l0IGEvTWFrZWZpbGUuYW0gYi9NYWtlZmls
ZS5hbTxicj4KJmd0OyBpbmRleCA4MjNiN2QwMi4uMjFkZDcwN2MgMTAwNjQ0PGJyPgomZ3Q7IC0t
LSBhL01ha2VmaWxlLmFtPGJyPgomZ3Q7ICsrKyBiL01ha2VmaWxlLmFtPGJyPgomZ3Q7IEBAIC02
MjcsNyArNjI3LDcgQEAgU0VEX1BST0NFU1MgPSAkKEFNX1ZfR0VOKSQoTUtESVJfUCkgJChkaXIg
JEApICZhbXA7JmFtcDsgJChTRUQpIFw8YnI+CiZndDsgPGJyPgomZ3Q7IGlmIFJVTl9SU1QyTUFO
PGJyPgomZ3Q7IFJTVDJNQU5fUFJPQ0VTUyA9ICQoQU1fVl9HRU4pJChSU1QyTUFOKSAtLXN0cmlj
dCAtLW5vLXJhdyAtLW5vLWdlbmVyYXRvciBcPGJyPgomZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoC0tbm8tZGF0ZXN0YW1wICZsdDsgJCZsdDsgJmd0OyAkQDxicj4KJmd0OyAr
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAtLW5vLWRhdGVzdGFtcDxicj4KJmd0OyBl
bHNlPGJyPgomZ3Q7IFJTVDJNQU5fUFJPQ0VTUyA9ICQoQU1fVl9HRU4pdGVzdCAtZiAkQCB8fCBc
PGJyPgomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB7IGVjaG8gJnF1b3Q7R2VuZXJhdGVkIG1h
bnVhbCBwYWdlICRAIGRvZXMgbm90IGV4aXN0JnF1b3Q7OyBmYWxzZTsgfTxicj4KPGJyPgpzbyB0
aGlzIGlzIGJhZCBpbiBjYXNlIHRoZSBlbHNlIGNsYXVzZSBpcyB1c2VkLjxicj4KPGJyPgomZ3Q7
IEBAIC02MzcsMTMgKzYzNywxMyBAQCBlbmRpZjxicj4KJmd0O8KgIMKgIMKgIMKgJChTRURfUFJP
Q0VTUyk8YnI+CiZndDsgPGJyPgomZ3Q7ICUuMTogJS5yc3QgTWFrZWZpbGU8YnI+CiZndDsgLcKg
IMKgIMKgJChSU1QyTUFOX1BST0NFU1MpPGJyPgomZ3Q7ICvCoCDCoCDCoCQoUlNUMk1BTl9QUk9D
RVNTKSAkJmx0OyAkQDxicj4KJmd0OyA8YnI+CiZndDsgJS41OiAlLnJzdCBNYWtlZmlsZTxicj4K
Jmd0OyAtwqAgwqAgwqAkKFJTVDJNQU5fUFJPQ0VTUyk8YnI+CiZndDsgK8KgIMKgIMKgJChSU1Qy
TUFOX1BST0NFU1MpICQmbHQ7ICRAPGJyPgomZ3Q7IDxicj4KJmd0OyAlLjg6ICUucnN0IE1ha2Vm
aWxlPGJyPgomZ3Q7IC3CoCDCoCDCoCQoUlNUMk1BTl9QUk9DRVNTKTxicj4KJmd0OyArwqAgwqAg
wqAkKFJTVDJNQU5fUFJPQ0VTUykgJCZsdDsgJEA8YnI+Cjxicj4KSXMgYWRkaW5nIHRoaXMgdG8g
dGhlIFJTVDJNQU5fUFJPQ0VTUyB2YXJpYWJsZSBub3Qgd29ya2luZz88L2Jsb2NrcXVvdGU+PGRp
diBkaXI9ImF1dG8iPjxicj48L2Rpdj48ZGl2IGRpcj0iYXV0byI+SSB0aGluayB0aGF0IHdpbGwg
d29yayBmaW5lIEkganVzdCBtb3ZlZCBpdCBoZXJlIGZvcjwvZGl2PjxkaXYgZGlyPSJhdXRvIj5D
b252ZW5pZW5jZSBJIGNhbiBtb3ZlIGl0IGJhY2sgSSB0aGluayByZWFsIHJhY2UgaXMgdGhhdCBk
aXJlY3RvcnkgaXMgbm90IGNyZWF0ZWQgYmVmb3JlIGEgZmlsZSBpbnNpZGUgdGhlIGRpcmVjdG9y
eSBpcyBiZWluZyByZWRpcmVjdGVkIHRvLiBUaGlzIGhhcHBlbnMgd2hlbiBkb2luZyBvdXQgb2Yg
dHJlZSBidWlsZCBzbyB0aGUgZGlyZWN0b3J5IGlzIG5vdCBwcmUgZXhpc3RpbmfCoDwvZGl2Pjxi
bG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2Jv
cmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPjxicj4KPGJyPgpSZWdh
cmRzPGJyPgo8YnI+Ck1hcmNlbDxicj4KPGJyPgo8L2Jsb2NrcXVvdGU+PC9kaXY+PC9kaXY+Cg==

--===============5982303572841136435==--

