Content-Type: multipart/mixed; boundary="===============7046933848700247827=="
MIME-Version: 1.0
From: Will Dietz <w@wdtz.org>
Subject: Fwd: [PATCH 09/16] unit: Update event handler in WSC, eapol tests
Date: Tue, 05 Nov 2019 04:37:47 -0600
Message-ID: <CAKGWAO_FKGY0Rb668+QcSpjG8=S=0+nzZ9kc3H_H4H3TGNtw1A@mail.gmail.com>
In-Reply-To: <20191104211542.GB2146@dtznix>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7046933848700247827==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Forwarding this as well, sigh. Sorry folks.

---------- Forwarded message ---------
From: Will Dietz <w@wdtz.org>
Date: Mon, Nov 4, 2019, 9:15 PM
Subject: Re: [PATCH 09/16] unit: Update event handler in WSC, eapol tests
To: Andrew Zaborowski <andrew.zaborowski@intel.com>


On Mon, 4 Nov 2019 21:02:07 -0600, Will Dietz <w@wdtz.org> wrote:
> On Mon, 28 Oct 2019 15:05:01 +0100, Andrew Zaborowski <
andrew.zaborowski@intel.com> wrote:
> >  {
> >     struct verify_data *data =3D user_data;
> > +   va_list args;
> > +
> > +   va_start(args, user_data);
> >
> >     switch (event) {
> >     case HANDSHAKE_EVENT_FAILED:
> > -           assert(l_get_u16(event_data) =3D=3D
> > -                           MMPDU_REASON_CODE_IEEE8021X_FAILED);
> > +           assert(va_arg(args, int) =3D=3D
MMPDU_REASON_CODE_IEEE8021X_FAILED);
> >             data->eapol_failed =3D true;
> >             break;
> > +   case HANDSHAKE_EVENT_EAP_NOTIFY:
> > +   {
> > +           const struct wsc_credential *cred;
> > +
> > +           assert(va_arg(args, unsigned int) !=3D
> > +                   EAP_WSC_EVENT_CREDENTIAL_OBTAINED);
>
> This condition appears to have been inverted accidentally :3.
> I noticed because this causes the test to (always) fail.
> Compare to the logic this replaces:
>
> > -
> > -   if (event !=3D EAP_WSC_EVENT_CREDENTIAL_OBTAINED)
> > -           assert(false);
> > -
>
> I'm not in a position to properly submit a patch currently,
> but if there's agreement on this please go ahead and fix :).
> (flipping the '!=3D' to '=3D=3D' in the assert does the trick, etc.)
>
> ~Will

Nit while visiting the file: the va_start calls don't have matching
va_end calls, which are present in wsc.c which test-wsc.c appears based
on.

Not a big deal, but happened to notice while inspecting.

~Will

--===============7046933848700247827==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9ImF1dG8iPkZvcndhcmRpbmcgdGhpcyBhcyB3ZWxsLCBzaWdoLiBTb3JyeSBmb2xr
cy48L2Rpdj48YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPjxkaXYgZGlyPSJsdHIiIGNsYXNz
PSJnbWFpbF9hdHRyIj4tLS0tLS0tLS0tIEZvcndhcmRlZCBtZXNzYWdlIC0tLS0tLS0tLTxicj5G
cm9tOiA8c3Ryb25nIGNsYXNzPSJnbWFpbF9zZW5kZXJuYW1lIiBkaXI9ImF1dG8iPldpbGwgRGll
dHo8L3N0cm9uZz4gPHNwYW4gZGlyPSJhdXRvIj4mbHQ7PGEgaHJlZj0ibWFpbHRvOndAd2R0ei5v
cmciPndAd2R0ei5vcmc8L2E+Jmd0Ozwvc3Bhbj48YnI+RGF0ZTogTW9uLCBOb3YgNCwgMjAxOSwg
OToxNSBQTTxicj5TdWJqZWN0OiBSZTogW1BBVENIIDA5LzE2XSB1bml0OiBVcGRhdGUgZXZlbnQg
aGFuZGxlciBpbiBXU0MsIGVhcG9sIHRlc3RzPGJyPlRvOiBBbmRyZXcgWmFib3Jvd3NraSAmbHQ7
PGEgaHJlZj0ibWFpbHRvOmFuZHJldy56YWJvcm93c2tpQGludGVsLmNvbSI+YW5kcmV3LnphYm9y
b3dza2lAaW50ZWwuY29tPC9hPiZndDs8YnI+PC9kaXY+PGJyPjxicj5PbiBNb24sIDQgTm92IDIw
MTkgMjE6MDI6MDcgLTA2MDAsIFdpbGwgRGlldHogJmx0OzxhIGhyZWY9Im1haWx0bzp3QHdkdHou
b3JnIiB0YXJnZXQ9Il9ibGFuayIgcmVsPSJub3JlZmVycmVyIj53QHdkdHoub3JnPC9hPiZndDsg
d3JvdGU6PGJyPgomZ3Q7IE9uIE1vbiwgMjggT2N0IDIwMTkgMTU6MDU6MDEgKzAxMDAsIEFuZHJl
dyBaYWJvcm93c2tpICZsdDs8YSBocmVmPSJtYWlsdG86YW5kcmV3LnphYm9yb3dza2lAaW50ZWwu
Y29tIiB0YXJnZXQ9Il9ibGFuayIgcmVsPSJub3JlZmVycmVyIj5hbmRyZXcuemFib3Jvd3NraUBp
bnRlbC5jb208L2E+Jmd0OyB3cm90ZTo8YnI+CiZndDsgJmd0O8KgIHs8YnI+CiZndDsgJmd0O8Kg
IMKgIMKgc3RydWN0IHZlcmlmeV9kYXRhICpkYXRhID0gdXNlcl9kYXRhOzxicj4KJmd0OyAmZ3Q7
ICvCoCDCoHZhX2xpc3QgYXJnczs8YnI+CiZndDsgJmd0OyArPGJyPgomZ3Q7ICZndDsgK8KgIMKg
dmFfc3RhcnQoYXJncywgdXNlcl9kYXRhKTs8YnI+CiZndDsgJmd0O8KgIDxicj4KJmd0OyAmZ3Q7
wqAgwqAgwqBzd2l0Y2ggKGV2ZW50KSB7PGJyPgomZ3Q7ICZndDvCoCDCoCDCoGNhc2UgSEFORFNI
QUtFX0VWRU5UX0ZBSUxFRDo8YnI+CiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqBhc3NlcnQo
bF9nZXRfdTE2KGV2ZW50X2RhdGEpID09PGJyPgomZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgTU1QRFVfUkVBU09OX0NPREVfSUVFRTgwMjFYX0ZBSUxF
RCk7PGJyPgomZ3Q7ICZndDsgK8KgIMKgIMKgIMKgIMKgIMKgYXNzZXJ0KHZhX2FyZyhhcmdzLCBp
bnQpID09IE1NUERVX1JFQVNPTl9DT0RFX0lFRUU4MDIxWF9GQUlMRUQpOzxicj4KJmd0OyAmZ3Q7
wqAgwqAgwqAgwqAgwqAgwqAgwqBkYXRhLSZndDtlYXBvbF9mYWlsZWQgPSB0cnVlOzxicj4KJmd0
OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqBicmVhazs8YnI+CiZndDsgJmd0OyArwqAgwqBjYXNl
IEhBTkRTSEFLRV9FVkVOVF9FQVBfTk9USUZZOjxicj4KJmd0OyAmZ3Q7ICvCoCDCoHs8YnI+CiZn
dDsgJmd0OyArwqAgwqAgwqAgwqAgwqAgwqBjb25zdCBzdHJ1Y3Qgd3NjX2NyZWRlbnRpYWwgKmNy
ZWQ7PGJyPgomZ3Q7ICZndDsgKzxicj4KJmd0OyAmZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoGFzc2Vy
dCh2YV9hcmcoYXJncywgdW5zaWduZWQgaW50KSAhPTxicj4KJmd0OyAmZ3Q7ICvCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoEVBUF9XU0NfRVZFTlRfQ1JFREVOVElBTF9PQlRBSU5FRCk7PGJy
PgomZ3Q7IDxicj4KJmd0OyBUaGlzIGNvbmRpdGlvbiBhcHBlYXJzIHRvIGhhdmUgYmVlbiBpbnZl
cnRlZCBhY2NpZGVudGFsbHkgOjMuPGJyPgomZ3Q7IEkgbm90aWNlZCBiZWNhdXNlIHRoaXMgY2F1
c2VzIHRoZSB0ZXN0IHRvIChhbHdheXMpIGZhaWwuPGJyPgomZ3Q7IENvbXBhcmUgdG8gdGhlIGxv
Z2ljIHRoaXMgcmVwbGFjZXM6PGJyPgomZ3Q7IDxicj4KJmd0OyAmZ3Q7IC08YnI+CiZndDsgJmd0
OyAtwqAgwqBpZiAoZXZlbnQgIT0gRUFQX1dTQ19FVkVOVF9DUkVERU5USUFMX09CVEFJTkVEKTxi
cj4KJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoGFzc2VydChmYWxzZSk7PGJyPgomZ3Q7ICZn
dDsgLTxicj4KJmd0OyA8YnI+CiZndDsgSSYjMzk7bSBub3QgaW4gYSBwb3NpdGlvbiB0byBwcm9w
ZXJseSBzdWJtaXQgYSBwYXRjaCBjdXJyZW50bHksPGJyPgomZ3Q7IGJ1dCBpZiB0aGVyZSYjMzk7
cyBhZ3JlZW1lbnQgb24gdGhpcyBwbGVhc2UgZ28gYWhlYWQgYW5kIGZpeCA6KS48YnI+CiZndDsg
KGZsaXBwaW5nIHRoZSAmIzM5OyE9JiMzOTsgdG8gJiMzOTs9PSYjMzk7IGluIHRoZSBhc3NlcnQg
ZG9lcyB0aGUgdHJpY2ssIGV0Yy4pPGJyPgomZ3Q7IDxicj4KJmd0OyB+V2lsbDxicj4KPGJyPgpO
aXQgd2hpbGUgdmlzaXRpbmcgdGhlIGZpbGU6IHRoZSB2YV9zdGFydCBjYWxscyBkb24mIzM5O3Qg
aGF2ZSBtYXRjaGluZzxicj4KdmFfZW5kIGNhbGxzLCB3aGljaCBhcmUgcHJlc2VudCBpbiB3c2Mu
YyB3aGljaCB0ZXN0LXdzYy5jIGFwcGVhcnMgYmFzZWQ8YnI+Cm9uLjxicj4KPGJyPgpOb3QgYSBi
aWcgZGVhbCwgYnV0IGhhcHBlbmVkIHRvIG5vdGljZSB3aGlsZSBpbnNwZWN0aW5nLjxicj4KPGJy
Pgp+V2lsbDxicj4KPC9kaXY+Cg==

--===============7046933848700247827==--

