Content-Type: multipart/mixed; boundary="===============6760756163558540545=="
MIME-Version: 1.0
From: Jimin Kim <dayo05 at daum.net>
To: iwd at lists.01.org
Subject: Re: [PATCH] Improve d-bus error message on iwctl
Date: Wed, 13 Apr 2022 18:34:06 +0900
Message-ID: <4f3b52f9-4a22-87d5-b20e-5a83ff6c8019@daum.net>
In-Reply-To: e16eb469e954aa1372f16ea8c40abb8f8114477f.camel@gmail.com

--===============6760756163558540545==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi,

On 4/2/22 01:41, James Prestwood wrote:
> Hi,
>
>>>
>> Ok. Then how about changing the message to "Check yourself exists on =

>> netdev usergroup". I know this error is able to happen with other =

>> reason. But this error can showed by newbie or users who is not =

>> friendly with linux. And also, d-bus error message is not friendly =

>> for normal users. So Adding additional information on error messageis =

>> need.
>>
>
> Yes something like "check that user is in the netdev group" would be =

> better. We'll have to see what others think. Whether we take this =

> option or just choose to add something to the wiki (and I'll go ahead =

> and do this anyways).

 =C2=A0I've thought about that and d-bus error message is not user-friendly =

and this error can showed with normal using and figured out this caused =

by broken change commit. And also if error is not showed by this reason, =

this will be important issue. Thats why I didn't remove previous dbus =

error message.

 =C2=A0Wiki is good place to locate information. But many users don't know =

iwd wiki exists because this program has pre-installed to many linux =

distros. So I think show this short information is required.

> I've also CC'd the list back in, make sure you reply all so others can =

> see the coversation.
>
>>
>> Jimin Kim.
>>
>>
>
This is the new patch.

Jimin Kim.


---
 =C2=A0client/dbus-proxy.c | 1 +
 =C2=A01 file changed, 1 insertion(+)

diff --git a/client/dbus-proxy.c b/client/dbus-proxy.c
index 0373a3df..8cad3ece 100644
--- a/client/dbus-proxy.c
+++ b/client/dbus-proxy.c
@@ -722,6 +722,7 @@ static void get_managed_objects_callback(struct =

l_dbus_message *message,
 =C2=A0=C2=A0=C2=A0 =C2=A0if (dbus_message_has_error(message)) {
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0display_error("Failed to retri=
eve IWD dbus objects, "
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0"quittin=
g...\n");
+=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0display("Check yourself exists on ne=
tdev usergroup.\n");

 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0goto error;
 =C2=A0=C2=A0=C2=A0 =C2=A0}
-- =

2.35.1



--===============6760756163558540545==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGh0bWw+CiAgPGhlYWQ+CiAgICA8bWV0YSBodHRwLWVxdWl2PSJDb250ZW50LVR5cGUiIGNvbnRl
bnQ9InRleHQvaHRtbDsgY2hhcnNldD1VVEYtOCI+CiAgPC9oZWFkPgogIDxib2R5PgogICAgPHA+
PGJyPgogICAgPC9wPgogICAgPGRpdiBjbGFzcz0ibW96LWNpdGUtcHJlZml4Ij5IaSw8YnI+CiAg
ICA8L2Rpdj4KICAgIDxkaXYgY2xhc3M9Im1vei1jaXRlLXByZWZpeCI+PGJyPgogICAgPC9kaXY+
CiAgICA8ZGl2IGNsYXNzPSJtb3otY2l0ZS1wcmVmaXgiPk9uIDQvMi8yMiAwMTo0MSwgSmFtZXMg
UHJlc3R3b29kIHdyb3RlOjxicj4KICAgIDwvZGl2PgogICAgPGJsb2NrcXVvdGUgdHlwZT0iY2l0
ZSIKICAgICAgY2l0ZT0ibWlkOmUxNmViNDY5ZTk1NGFhMTM3MmYxNmVhOGM0MGFiYjhmODExNDQ3
N2YuY2FtZWxAZ21haWwuY29tIj4KICAgICAgPG1ldGEgaHR0cC1lcXVpdj0iY29udGVudC10eXBl
IiBjb250ZW50PSJ0ZXh0L2h0bWw7IGNoYXJzZXQ9VVRGLTgiPgogICAgICBIaSwKICAgICAgPGRp
dj48YnI+CiAgICAgICAgPGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSIgc3R5bGU9Im1hcmdpbjowIDAg
MCAuOGV4OwogICAgICAgICAgYm9yZGVyLWxlZnQ6MnB4ICM3MjlmY2Ygc29saWQ7cGFkZGluZy1s
ZWZ0OjFleCI+CiAgICAgICAgICA8YmxvY2txdW90ZSB0eXBlPSJjaXRlIgogICAgICAgICAgICBj
aXRlPSJtaWQ6OGI2MTFjNjhiZGM1NWFmY2I5Mjk0OGM5NzA5MTlmODA3Yjk5ZGMzMC5jYW1lbEBn
bWFpbC5jb20iCiAgICAgICAgICAgIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDsgYm9yZGVyLWxl
ZnQ6MnB4ICM3MjlmY2YKICAgICAgICAgICAgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+CiAgICAg
ICAgICAgIDxkaXY+PGJyPgogICAgICAgICAgICA8L2Rpdj4KICAgICAgICAgIDwvYmxvY2txdW90
ZT4KICAgICAgICAgIDxwPk9rLiBUaGVuIGhvdyBhYm91dCBjaGFuZ2luZyB0aGUgbWVzc2FnZSB0
byAiQ2hlY2sgeW91cnNlbGYKICAgICAgICAgICAgZXhpc3RzIG9uIG5ldGRldiB1c2VyZ3JvdXAi
LiBJIGtub3cgdGhpcyBlcnJvciBpcyBhYmxlIHRvCiAgICAgICAgICAgIGhhcHBlbiB3aXRoIG90
aGVyIHJlYXNvbi4gQnV0IHRoaXMgZXJyb3IgY2FuIHNob3dlZCBieQogICAgICAgICAgICBuZXdi
aWUgb3IgdXNlcnMgd2hvIGlzIG5vdCBmcmllbmRseSB3aXRoIGxpbnV4LiBBbmQgYWxzbywKICAg
ICAgICAgICAgZC1idXMgZXJyb3IgbWVzc2FnZSBpcyBub3QgZnJpZW5kbHkgZm9yIG5vcm1hbCB1
c2Vycy4gU28KICAgICAgICAgICAgQWRkaW5nIGFkZGl0aW9uYWwgaW5mb3JtYXRpb24gb24gZXJy
b3IgbWVzc2FnZWlzIG5lZWQuPC9wPgogICAgICAgIDwvYmxvY2txdW90ZT4KICAgICAgPC9kaXY+
CiAgICAgIDxkaXY+PGJyPgogICAgICA8L2Rpdj4KICAgICAgPGRpdj5ZZXMgc29tZXRoaW5nIGxp
a2UgImNoZWNrIHRoYXQgdXNlciBpcyBpbiB0aGUgbmV0ZGV2IGdyb3VwIgogICAgICAgIHdvdWxk
IGJlIGJldHRlci4gV2UnbGwgaGF2ZSB0byBzZWUgd2hhdCBvdGhlcnMgdGhpbmsuIFdoZXRoZXIg
d2UKICAgICAgICB0YWtlIHRoaXMgb3B0aW9uIG9yIGp1c3QgY2hvb3NlIHRvIGFkZCBzb21ldGhp
bmcgdG8gdGhlIHdpa2kKICAgICAgICAoYW5kIEknbGwgZ28gYWhlYWQgYW5kIGRvIHRoaXMgYW55
d2F5cykuPC9kaXY+CiAgICA8L2Jsb2NrcXVvdGU+CiAgICA8cD7CoEkndmUgdGhvdWdodCBhYm91
dCB0aGF0IGFuZCBkLWJ1cyBlcnJvciBtZXNzYWdlIGlzIG5vdAogICAgICB1c2VyLWZyaWVuZGx5
IGFuZCB0aGlzIGVycm9yIGNhbiBzaG93ZWQgd2l0aCBub3JtYWwgdXNpbmcgYW5kCiAgICAgIGZp
Z3VyZWQgb3V0IHRoaXMgY2F1c2VkIGJ5IGJyb2tlbiBjaGFuZ2UgY29tbWl0LiBBbmQgYWxzbyBp
ZiBlcnJvcgogICAgICBpcyBub3Qgc2hvd2VkIGJ5IHRoaXMgcmVhc29uLCB0aGlzIHdpbGwgYmUg
aW1wb3J0YW50IGlzc3VlLiBUaGF0cwogICAgICB3aHkgSSBkaWRuJ3QgcmVtb3ZlIHByZXZpb3Vz
IGRidXMgZXJyb3IgbWVzc2FnZS4gPGJyPgogICAgPC9wPgogICAgPHA+wqBXaWtpIGlzIGdvb2Qg
cGxhY2UgdG8gbG9jYXRlIGluZm9ybWF0aW9uLiBCdXQgbWFueSB1c2VycyBkb24ndAogICAgICBr
bm93IGl3ZCB3aWtpIGV4aXN0cyBiZWNhdXNlIHRoaXMgcHJvZ3JhbSBoYXMgcHJlLWluc3RhbGxl
ZCB0bwogICAgICBtYW55IGxpbnV4IGRpc3Ryb3MuIFNvIEkgdGhpbmsgc2hvdyB0aGlzIHNob3J0
IGluZm9ybWF0aW9uIGlzCiAgICAgIHJlcXVpcmVkLjxicj4KICAgIDwvcD4KICAgIDxibG9ja3F1
b3RlIHR5cGU9ImNpdGUiCiAgICAgIGNpdGU9Im1pZDplMTZlYjQ2OWU5NTRhYTEzNzJmMTZlYThj
NDBhYmI4ZjgxMTQ0NzdmLmNhbWVsQGdtYWlsLmNvbSI+CiAgICAgIDxkaXY+SSd2ZSBhbHNvIEND
J2QgdGhlIGxpc3QgYmFjayBpbiwgbWFrZSBzdXJlIHlvdSByZXBseSBhbGwgc28KICAgICAgICBv
dGhlcnMgY2FuIHNlZSB0aGUgY292ZXJzYXRpb24uPC9kaXY+CiAgICA8L2Jsb2NrcXVvdGU+CiAg
ICA8YmxvY2txdW90ZSB0eXBlPSJjaXRlIgogICAgICBjaXRlPSJtaWQ6ZTE2ZWI0NjllOTU0YWEx
MzcyZjE2ZWE4YzQwYWJiOGY4MTE0NDc3Zi5jYW1lbEBnbWFpbC5jb20iPgogICAgICA8ZGl2Pjxi
cj4KICAgICAgPC9kaXY+CiAgICAgIDxkaXY+CiAgICAgICAgPGJsb2NrcXVvdGUgdHlwZT0iY2l0
ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4OwogICAgICAgICAgYm9yZGVyLWxlZnQ6MnB4ICM3
MjlmY2Ygc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+CiAgICAgICAgICA8cD48YnI+CiAgICAgICAg
ICA8L3A+CiAgICAgICAgICA8cD5KaW1pbiBLaW0uPGJyPgogICAgICAgICAgPC9wPgogICAgICAg
ICAgPHA+PGJyPgogICAgICAgICAgPC9wPgogICAgICAgICAgPGRpdj4gPC9kaXY+CiAgICAgICAg
PC9ibG9ja3F1b3RlPgogICAgICAgIDxkaXY+PGJyPgogICAgICAgIDwvZGl2PgogICAgICA8L2Rp
dj4KICAgIDwvYmxvY2txdW90ZT4KICAgIDxwPlRoaXMgaXMgdGhlIG5ldyBwYXRjaC48L3A+CiAg
ICA8cD5KaW1pbiBLaW0uPGJyPgogICAgPC9wPgogICAgPHA+PGJyPgogICAgPC9wPgogICAgPHA+
LS0tPGJyPgogICAgICDCoGNsaWVudC9kYnVzLXByb3h5LmMgfCAxICs8YnI+CiAgICAgIMKgMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspPGJyPgogICAgICA8YnI+CiAgICAgIGRpZmYgLS1n
aXQgYS9jbGllbnQvZGJ1cy1wcm94eS5jIGIvY2xpZW50L2RidXMtcHJveHkuYzxicj4KICAgICAg
aW5kZXggMDM3M2EzZGYuLjhjYWQzZWNlIDEwMDY0NDxicj4KICAgICAgLS0tIGEvY2xpZW50L2Ri
dXMtcHJveHkuYzxicj4KICAgICAgKysrIGIvY2xpZW50L2RidXMtcHJveHkuYzxicj4KICAgICAg
QEAgLTcyMiw2ICs3MjIsNyBAQCBzdGF0aWMgdm9pZAogICAgICBnZXRfbWFuYWdlZF9vYmplY3Rz
X2NhbGxiYWNrKHN0cnVjdCBsX2RidXNfbWVzc2FnZSAqbWVzc2FnZSw8YnI+CiAgICAgIMKgwqDC
oCDCoGlmIChkYnVzX21lc3NhZ2VfaGFzX2Vycm9yKG1lc3NhZ2UpKSB7PGJyPgogICAgICDCoMKg
wqAgwqDCoMKgIMKgZGlzcGxheV9lcnJvcigiRmFpbGVkIHRvIHJldHJpZXZlIElXRCBkYnVzIG9i
amVjdHMsICI8YnI+CiAgICAgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDC
oMKgIMKgwqDCoCDCoCJxdWl0dGluZy4uLlxuIik7PGJyPgogICAgICArwqDCoCDCoMKgwqAgwqBk
aXNwbGF5KCJDaGVjayB5b3Vyc2VsZiBleGlzdHMgb24gbmV0ZGV2IHVzZXJncm91cC5cbiIpOzxi
cj4KICAgICAgwqA8YnI+CiAgICAgIMKgwqDCoCDCoMKgwqAgwqBnb3RvIGVycm9yOzxicj4KICAg
ICAgwqDCoMKgIMKgfTxicj4KICAgICAgLS0gPGJyPgogICAgICAyLjM1LjE8L3A+CiAgICA8cD48
YnI+CiAgICA8L3A+CiAgICA8cD48YnI+CiAgICA8L3A+CiAgICA8YmxvY2txdW90ZSB0eXBlPSJj
aXRlIgogICAgICBjaXRlPSJtaWQ6ZTE2ZWI0NjllOTU0YWExMzcyZjE2ZWE4YzQwYWJiOGY4MTE0
NDc3Zi5jYW1lbEBnbWFpbC5jb20iPgogICAgICA8ZGl2PgogICAgICAgIDxkaXY+PHNwYW4+PC9z
cGFuPjwvZGl2PgogICAgICAgIDxzdHlsZT5we21hcmdpbi10b3A6MDttYXJnaW4tYm90dG9tOjB9
PC9zdHlsZT48L2Rpdj4KICAgIDwvYmxvY2txdW90ZT4KICA8L2JvZHk+CjwvaHRtbD4K

--===============6760756163558540545==--

