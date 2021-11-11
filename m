Content-Type: multipart/mixed; boundary="===============3146219618212433222=="
MIME-Version: 1.0
From: =?utf-8?q?Andr=C3=A9s_Gonz=C3=A1lez_=3Cgonzalez=2Eaf_at_gmail=2Ecom=3E?=
To: iwd at lists.01.org
Subject: BUG: iwctl v1.19 (get-networks, command line mode)
Date: Wed, 10 Nov 2021 21:31:28 -0500
Message-ID: <CAAMTFnOYXJnSdGWbcrhxXBnRfw5cPgMSztJaJ+ee9xTHg-REVg@mail.gmail.com>

--===============3146219618212433222==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,
After upgrading to v1.19 the following no longer works:

*Command line mode*
$ iwctl station DEVICE scan
$ iwctl station DEVICE get-networks

The second command returns blank. Other commands like "show" work just
fine. Also interactive mode works just fine.
I have downgraded the package to v1.18 and it works well (while I did not
restart the service), so seems to perhaps be the client only?

-- =

-andr=C3=A9s

--===============3146219618212433222==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0
ciI+PGRpdiBkaXI9Imx0ciI+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU9ImZvbnQt
ZmFtaWx5OmFyaWFsLGhlbHZldGljYSxzYW5zLXNlcmlmIj5IZWxsbyw8L2Rpdj48ZGl2IGNsYXNz
PSJnbWFpbF9kZWZhdWx0IiBzdHlsZT0iZm9udC1mYW1pbHk6YXJpYWwsaGVsdmV0aWNhLHNhbnMt
c2VyaWYiPkFmdGVyIHVwZ3JhZGluZyB0byB2MS4xOSB0aGUgZm9sbG93aW5nIG5vIGxvbmdlciB3
b3Jrczo8YnI+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU9ImZvbnQtZmFt
aWx5OmFyaWFsLGhlbHZldGljYSxzYW5zLXNlcmlmIj48YnI+PC9kaXY+PGRpdiBjbGFzcz0iZ21h
aWxfZGVmYXVsdCIgc3R5bGU9ImZvbnQtZmFtaWx5OmFyaWFsLGhlbHZldGljYSxzYW5zLXNlcmlm
Ij4qQ29tbWFuZCBsaW5lIG1vZGUqPGJyPjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQi
IHN0eWxlPSJmb250LWZhbWlseTphcmlhbCxoZWx2ZXRpY2Esc2Fucy1zZXJpZiI+JCBpd2N0bCBz
dGF0aW9uIERFVklDRSBzY2FuPC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU9
ImZvbnQtZmFtaWx5OmFyaWFsLGhlbHZldGljYSxzYW5zLXNlcmlmIj4kIGl3Y3RsIHN0YXRpb24g
REVWSUNFIGdldC1uZXR3b3JrczwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxl
PSJmb250LWZhbWlseTphcmlhbCxoZWx2ZXRpY2Esc2Fucy1zZXJpZiI+PGJyPjwvZGl2PjxkaXYg
Y2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPSJmb250LWZhbWlseTphcmlhbCxoZWx2ZXRpY2Es
c2Fucy1zZXJpZiI+VGhlIHNlY29uZCBjb21tYW5kIHJldHVybnMgYmxhbmsuIE90aGVyIGNvbW1h
bmRzIGxpa2UgJnF1b3Q7c2hvdyZxdW90OyB3b3JrIGp1c3QgZmluZS4gQWxzbyBpbnRlcmFjdGl2
ZSBtb2RlIHdvcmtzIGp1c3QgZmluZS48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBz
dHlsZT0iZm9udC1mYW1pbHk6YXJpYWwsaGVsdmV0aWNhLHNhbnMtc2VyaWYiPkkgaGF2ZSBkb3du
Z3JhZGVkIHRoZSBwYWNrYWdlIHRvIHYxLjE4IGFuZCBpdCB3b3JrcyB3ZWxsICh3aGlsZSBJIGRp
ZCBub3QgcmVzdGFydCB0aGUgc2VydmljZSksIHNvIHNlZW1zIHRvIHBlcmhhcHMgYmUgdGhlIGNs
aWVudCBvbmx5PzwvZGl2Pjxicj4tLSA8YnI+PGRpdiBkaXI9Imx0ciIgY2xhc3M9ImdtYWlsX3Np
Z25hdHVyZSI+LWFuZHLDqXM8L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj4K

--===============3146219618212433222==--

