Content-Type: multipart/mixed; boundary="===============3665843377684125608=="
MIME-Version: 1.0
From: Will Dietz <w@wdtz.org>
Subject: Fwd: [PATCH 09/16] unit: Update event handler in WSC, eapol tests
Date: Tue, 05 Nov 2019 04:35:53 -0600
Message-ID: <CAKGWAO9pYgPuq=6JCsjBtSppH3KXD503ovskc5zyAQk9PjGgZg@mail.gmail.com>
In-Reply-To: <20191104210207.GB15819@dtznix>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3665843377684125608==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Whoops, meant to send to list, sorry!

---------- Forwarded message ---------
From: Will Dietz <w@wdtz.org>
Date: Mon, Nov 4, 2019, 9:02 PM
Subject: Re: [PATCH 09/16] unit: Update event handler in WSC, eapol tests
To: Andrew Zaborowski <andrew.zaborowski@intel.com>


On Mon, 28 Oct 2019 15:05:01 +0100, Andrew Zaborowski <
andrew.zaborowski@intel.com> wrote:
>  {
>       struct verify_data *data =3D user_data;
> +     va_list args;
> +
> +     va_start(args, user_data);
>
>       switch (event) {
>       case HANDSHAKE_EVENT_FAILED:
> -             assert(l_get_u16(event_data) =3D=3D
> -                             MMPDU_REASON_CODE_IEEE8021X_FAILED);
> +             assert(va_arg(args, int) =3D=3D
MMPDU_REASON_CODE_IEEE8021X_FAILED);
>               data->eapol_failed =3D true;
>               break;
> +     case HANDSHAKE_EVENT_EAP_NOTIFY:
> +     {
> +             const struct wsc_credential *cred;
> +
> +             assert(va_arg(args, unsigned int) !=3D
> +                     EAP_WSC_EVENT_CREDENTIAL_OBTAINED);

This condition appears to have been inverted accidentally :3.
I noticed because this causes the test to (always) fail.
Compare to the logic this replaces:

> -
> -     if (event !=3D EAP_WSC_EVENT_CREDENTIAL_OBTAINED)
> -             assert(false);
> -

I'm not in a position to properly submit a patch currently,
but if there's agreement on this please go ahead and fix :).
(flipping the '!=3D' to '=3D=3D' in the assert does the trick, etc.)

~Will

--===============3665843377684125608==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9ImF1dG8iPjxkaXY+V2hvb3BzLCBtZWFudCB0byBzZW5kIHRvIGxpc3QsIHNvcnJ5
ITxicj48YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPjxkaXYgZGlyPSJsdHIiIGNsYXNzPSJn
bWFpbF9hdHRyIj4tLS0tLS0tLS0tIEZvcndhcmRlZCBtZXNzYWdlIC0tLS0tLS0tLTxicj5Gcm9t
OiA8c3Ryb25nIGNsYXNzPSJnbWFpbF9zZW5kZXJuYW1lIiBkaXI9ImF1dG8iPldpbGwgRGlldHo8
L3N0cm9uZz4gPHNwYW4gZGlyPSJhdXRvIj4mbHQ7PGEgaHJlZj0ibWFpbHRvOndAd2R0ei5vcmci
PndAd2R0ei5vcmc8L2E+Jmd0Ozwvc3Bhbj48YnI+RGF0ZTogTW9uLCBOb3YgNCwgMjAxOSwgOTow
MiBQTTxicj5TdWJqZWN0OiBSZTogW1BBVENIIDA5LzE2XSB1bml0OiBVcGRhdGUgZXZlbnQgaGFu
ZGxlciBpbiBXU0MsIGVhcG9sIHRlc3RzPGJyPlRvOiBBbmRyZXcgWmFib3Jvd3NraSAmbHQ7PGEg
aHJlZj0ibWFpbHRvOmFuZHJldy56YWJvcm93c2tpQGludGVsLmNvbSI+YW5kcmV3LnphYm9yb3dz
a2lAaW50ZWwuY29tPC9hPiZndDs8YnI+PC9kaXY+PGJyPjxicj5PbiBNb24sIDI4IE9jdCAyMDE5
IDE1OjA1OjAxICswMTAwLCBBbmRyZXcgWmFib3Jvd3NraSAmbHQ7PGEgaHJlZj0ibWFpbHRvOmFu
ZHJldy56YWJvcm93c2tpQGludGVsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiIHJlbD0ibm9yZWZlcnJl
ciI+YW5kcmV3LnphYm9yb3dza2lAaW50ZWwuY29tPC9hPiZndDsgd3JvdGU6PGJyPgomZ3Q7wqAg
ezxicj4KJmd0O8KgIMKgIMKgIMKgc3RydWN0IHZlcmlmeV9kYXRhICpkYXRhID0gdXNlcl9kYXRh
Ozxicj4KJmd0OyArwqAgwqAgwqB2YV9saXN0IGFyZ3M7PGJyPgomZ3Q7ICs8YnI+CiZndDsgK8Kg
IMKgIMKgdmFfc3RhcnQoYXJncywgdXNlcl9kYXRhKTs8YnI+CiZndDvCoCA8YnI+CiZndDvCoCDC
oCDCoCDCoHN3aXRjaCAoZXZlbnQpIHs8YnI+CiZndDvCoCDCoCDCoCDCoGNhc2UgSEFORFNIQUtF
X0VWRU5UX0ZBSUxFRDo8YnI+CiZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgYXNzZXJ0KGxfZ2V0
X3UxNihldmVudF9kYXRhKSA9PTxicj4KJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBNTVBEVV9SRUFTT05fQ09ERV9JRUVFODAyMVhfRkFJTEVEKTs8YnI+
CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgYXNzZXJ0KHZhX2FyZyhhcmdzLCBpbnQpID09IE1N
UERVX1JFQVNPTl9DT0RFX0lFRUU4MDIxWF9GQUlMRUQpOzxicj4KJmd0O8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgZGF0YS0mZ3Q7ZWFwb2xfZmFpbGVkID0gdHJ1ZTs8YnI+CiZndDvCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoGJyZWFrOzxicj4KJmd0OyArwqAgwqAgwqBjYXNlIEhBTkRTSEFLRV9FVkVO
VF9FQVBfTk9USUZZOjxicj4KJmd0OyArwqAgwqAgwqB7PGJyPgomZ3Q7ICvCoCDCoCDCoCDCoCDC
oCDCoCDCoGNvbnN0IHN0cnVjdCB3c2NfY3JlZGVudGlhbCAqY3JlZDs8YnI+CiZndDsgKzxicj4K
Jmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqBhc3NlcnQodmFfYXJnKGFyZ3MsIHVuc2lnbmVkIGlu
dCkgIT08YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgRUFQX1dTQ19F
VkVOVF9DUkVERU5USUFMX09CVEFJTkVEKTs8YnI+Cjxicj4KVGhpcyBjb25kaXRpb24gYXBwZWFy
cyB0byBoYXZlIGJlZW4gaW52ZXJ0ZWQgYWNjaWRlbnRhbGx5IDozLjxicj4KSSBub3RpY2VkIGJl
Y2F1c2UgdGhpcyBjYXVzZXMgdGhlIHRlc3QgdG8gKGFsd2F5cykgZmFpbC48YnI+CkNvbXBhcmUg
dG8gdGhlIGxvZ2ljIHRoaXMgcmVwbGFjZXM6PGJyPgo8YnI+CiZndDsgLTxicj4KJmd0OyAtwqAg
wqAgwqBpZiAoZXZlbnQgIT0gRUFQX1dTQ19FVkVOVF9DUkVERU5USUFMX09CVEFJTkVEKTxicj4K
Jmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqBhc3NlcnQoZmFsc2UpOzxicj4KJmd0OyAtPGJyPgo8
YnI+CkkmIzM5O20gbm90IGluIGEgcG9zaXRpb24gdG8gcHJvcGVybHkgc3VibWl0IGEgcGF0Y2gg
Y3VycmVudGx5LDxicj4KYnV0IGlmIHRoZXJlJiMzOTtzIGFncmVlbWVudCBvbiB0aGlzIHBsZWFz
ZSBnbyBhaGVhZCBhbmQgZml4IDopLjxicj4KKGZsaXBwaW5nIHRoZSAmIzM5OyE9JiMzOTsgdG8g
JiMzOTs9PSYjMzk7IGluIHRoZSBhc3NlcnQgZG9lcyB0aGUgdHJpY2ssIGV0Yy4pPGJyPgo8YnI+
Cn5XaWxsPGJyPgo8L2Rpdj48L2Rpdj48L2Rpdj4K

--===============3665843377684125608==--

