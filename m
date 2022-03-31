Content-Type: multipart/mixed; boundary="===============0687779978371093959=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH] Improve d-bus error message on iwctl
Date: Thu, 31 Mar 2022 08:56:48 -0700
Message-ID: <8b611c68bdc55afcb92948c970919f807b99dc30.camel@gmail.com>
In-Reply-To: 20220331171050.QGFDw5V2QzKCgc9ClG0jFw@dayo05.hanmail.net

--===============0687779978371093959==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 2022-03-31 at 17:10 +0900, Dayo wrote:
> I got error of =

> =EF=BB=BFRejected send message, 2 matched rules; type=3D"method_call",
> sender=3D":1.137" (uid=3D1000 pid=3D14325 comm=3D"client/iwctl")
> interface=3D"org.freedesktop.DBus.ObjectManager"
> member=3D"GetManagedObjects" error name=3D"(unset)" requested_reply=3D"0"
> destination=3D"net.connman.iwd" (uid=3D0 pid=3D354 comm=3D"/usr/lib/iwd/i=
wd")
> in execution of iwctl without sudo. But when I tried to search that,
> It has low information in google but I solve the issue as executing
> with sudo. So this is very small change but this will improve this
> software.
> =EF=BB=BF
> =EF=BB=BFps. I get issue in linux kernel 5.16 and later, including 5.17.x

This is actually result of removing =C2=A0'at_console' from the dbus
configuration which we did a couple releases ago. The fix here is to
add your user to the netdev group if you don't want to run with root.
I'm not sure we want this debug print as-is for a few reasons. First
being that it should explain the netdev group requirement rather than
'root permission'. And second that this could be an error for any
number of reasons, not necissarily because of permissions.

https://git.kernel.org/pub/scm/network/wireless/iwd.git/commit/?id=3D010b0e=
27f98442ad9366ecdcb09601f92334c293

> =EF=BB=BF
> =EF=BB=BF
> =EF=BB=BF---
> =C2=A0client/dbus-proxy.c | 1 +
> =C2=A01 file changed, 1 insertion(+)
> =

> diff --git a/client/dbus-proxy.c b/client/dbus-proxy.c
> index 0373a3df..8cad3ece 100644
> --- a/client/dbus-proxy.c
> +++ b/client/dbus-proxy.c
> @@ -722,6 +722,7 @@ static void get_managed_objects_callback(struct
> l_dbus_message *message,
> =C2=A0=C2=A0=C2=A0 =C2=A0if (dbus_message_has_error(message)) {
> =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0display_error("Failed to retr=
ieve IWD dbus objects, "
> =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0"quittin=
g...\n");
> +=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0display("Execute iwctl with root p=
ermission is the one way
> to solve this issue.\n");
> =C2=A0
> =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0goto error;
> =C2=A0=C2=A0=C2=A0 =C2=A0}
> _______________________________________________
> iwd mailing list -- iwd(a)lists.01.org
> To unsubscribe send an email to iwd-leave(a)lists.01.org


--===============0687779978371093959==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGh0bWw+PGhlYWQ+CiAgICA8c3R5bGU+CiAgICAgICAgcHttYXJnaW4tdG9wOjA7bWFyZ2luLWJv
dHRvbTowfQogICAgPC9zdHlsZT4KPC9oZWFkPgo8Ym9keT48ZGl2PkhpLDwvZGl2PjxkaXY+PGJy
PjwvZGl2PjxkaXY+T24gVGh1LCAyMDIyLTAzLTMxIGF0IDE3OjEwICswOTAwLCBEYXlvIHdyb3Rl
OjwvZGl2PjxibG9ja3F1b3RlIHR5cGU9ImNpdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDsg
Ym9yZGVyLWxlZnQ6MnB4ICM3MjlmY2Ygc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+PGRpdiBzdHls
ZT0iY29sb3I6IzExMTtmb250LWZhbWlseTpBcHBsZSBTRCBHb3RoaWMgTmVvLE1hbGd1biBHb3Ro
aWMsJ+unkeydgCDqs6DrlJUnLHNhbnMtc2VyaWY7Zm9udC1zaXplOjEwcHQ7bGluZS1oZWlnaHQ6
MS41OyI+PHA+SSBnb3QgZXJyb3Igb2YgPGJyPjwvcD48cD7vu79SZWplY3RlZCBzZW5kIG1lc3Nh
Z2UsIDIgbWF0Y2hlZCBydWxlczsgdHlwZT0ibWV0aG9kX2NhbGwiLCBzZW5kZXI9IjoxLjEzNyIg
KHVpZD0xMDAwIHBpZD0xNDMyNSBjb21tPSJjbGllbnQvaXdjdGwiKSBpbnRlcmZhY2U9Im9yZy5m
cmVlZGVza3RvcC5EQnVzLk9iamVjdE1hbmFnZXIiIG1lbWJlcj0iR2V0TWFuYWdlZE9iamVjdHMi
IGVycm9yIG5hbWU9Iih1bnNldCkiIHJlcXVlc3RlZF9yZXBseT0iMCIgZGVzdGluYXRpb249Im5l
dC5jb25ubWFuLml3ZCIgKHVpZD0wIHBpZD0zNTQgY29tbT0iL3Vzci9saWIvaXdkL2l3ZCIpPGJy
PmluIGV4ZWN1dGlvbiBvZiBpd2N0bCB3aXRob3V0IHN1ZG8uIEJ1dCB3aGVuIEkgdHJpZWQgdG8g
c2VhcmNoIHRoYXQsIEl0IGhhcyBsb3cgaW5mb3JtYXRpb24gaW4gZ29vZ2xlIGJ1dCBJIHNvbHZl
IHRoZSBpc3N1ZSBhcyBleGVjdXRpbmcgd2l0aCBzdWRvLiBTbyB0aGlzIGlzIHZlcnkgc21hbGwg
Y2hhbmdlIGJ1dCB0aGlzIHdpbGwgaW1wcm92ZSB0aGlzIHNvZnR3YXJlLjwvcD48cD7vu788L3A+
PHA+77u/cHMuIEkgZ2V0IGlzc3VlIGluIGxpbnV4IGtlcm5lbCA1LjE2IGFuZCBsYXRlciwgaW5j
bHVkaW5nIDUuMTcueDxicj48L3A+PC9kaXY+PC9ibG9ja3F1b3RlPjxkaXY+PGJyPjwvZGl2Pjxk
aXY+VGhpcyBpcyBhY3R1YWxseSByZXN1bHQgb2YgcmVtb3ZpbmcgJm5ic3A7J2F0X2NvbnNvbGUn
IGZyb20gdGhlIGRidXMgY29uZmlndXJhdGlvbiB3aGljaCB3ZSBkaWQgYSBjb3VwbGUgcmVsZWFz
ZXMgYWdvLiBUaGUgZml4IGhlcmUgaXMgdG8gYWRkIHlvdXIgdXNlciB0byB0aGUgbmV0ZGV2IGdy
b3VwIGlmIHlvdSBkb24ndCB3YW50IHRvIHJ1biB3aXRoIHJvb3QuIEknbSBub3Qgc3VyZSB3ZSB3
YW50IHRoaXMgZGVidWcgcHJpbnQgYXMtaXMgZm9yIGEgZmV3IHJlYXNvbnMuIEZpcnN0IGJlaW5n
IHRoYXQgaXQgc2hvdWxkIGV4cGxhaW4gdGhlIG5ldGRldiBncm91cCByZXF1aXJlbWVudCByYXRo
ZXIgdGhhbiAncm9vdCBwZXJtaXNzaW9uJy4gQW5kIHNlY29uZCB0aGF0IHRoaXMgY291bGQgYmUg
YW4gZXJyb3IgZm9yIGFueSBudW1iZXIgb2YgcmVhc29ucywgbm90IG5lY2lzc2FyaWx5IGJlY2F1
c2Ugb2YgcGVybWlzc2lvbnMuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48YSBocmVmPSJodHRw
czovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbmV0d29yay93aXJlbGVzcy9pd2QuZ2l0L2NvbW1p
dC8/aWQ9MDEwYjBlMjdmOTg0NDJhZDkzNjZlY2RjYjA5NjAxZjkyMzM0YzI5MyI+aHR0cHM6Ly9n
aXQua2VybmVsLm9yZy9wdWIvc2NtL25ldHdvcmsvd2lyZWxlc3MvaXdkLmdpdC9jb21taXQvP2lk
PTAxMGIwZTI3Zjk4NDQyYWQ5MzY2ZWNkY2IwOTYwMWY5MjMzNGMyOTM8L2E+PC9kaXY+PGRpdj48
YnI+PC9kaXY+PGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4
OyBib3JkZXItbGVmdDoycHggIzcyOWZjZiBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij48ZGl2IHN0
eWxlPSJjb2xvcjojMTExO2ZvbnQtZmFtaWx5OkFwcGxlIFNEIEdvdGhpYyBOZW8sTWFsZ3VuIEdv
dGhpYywn66eR7J2AIOqzoOuUlScsc2Fucy1zZXJpZjtmb250LXNpemU6MTBwdDtsaW5lLWhlaWdo
dDoxLjU7Ij48cD7vu788L3A+PHA+77u/PGJyPjwvcD48cD7vu78tLS08YnI+Jm5ic3A7Y2xpZW50
L2RidXMtcHJveHkuYyB8IDEgKzxicj4mbmJzcDsxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
Kyk8YnI+PGJyPmRpZmYgLS1naXQgYS9jbGllbnQvZGJ1cy1wcm94eS5jIGIvY2xpZW50L2RidXMt
cHJveHkuYzxicj5pbmRleCAwMzczYTNkZi4uOGNhZDNlY2UgMTAwNjQ0PGJyPi0tLSBhL2NsaWVu
dC9kYnVzLXByb3h5LmM8YnI+KysrIGIvY2xpZW50L2RidXMtcHJveHkuYzxicj5AQCAtNzIyLDYg
KzcyMiw3IEBAIHN0YXRpYyB2b2lkIGdldF9tYW5hZ2VkX29iamVjdHNfY2FsbGJhY2soc3RydWN0
IGxfZGJ1c19tZXNzYWdlICptZXNzYWdlLDxicj4mbmJzcDsmbmJzcDsmbmJzcDsgJm5ic3A7aWYg
KGRidXNfbWVzc2FnZV9oYXNfZXJyb3IobWVzc2FnZSkpIHs8YnI+Jm5ic3A7Jm5ic3A7Jm5ic3A7
ICZuYnNwOyZuYnNwOyZuYnNwOyAmbmJzcDtkaXNwbGF5X2Vycm9yKCJGYWlsZWQgdG8gcmV0cmll
dmUgSVdEIGRidXMgb2JqZWN0cywgIjxicj4mbmJzcDsmbmJzcDsmbmJzcDsgJm5ic3A7Jm5ic3A7
Jm5ic3A7ICZuYnNwOyZuYnNwOyZuYnNwOyAmbmJzcDsmbmJzcDsmbmJzcDsgJm5ic3A7Jm5ic3A7
Jm5ic3A7ICZuYnNwOyZuYnNwOyZuYnNwOyAmbmJzcDsmbmJzcDsmbmJzcDsgJm5ic3A7InF1aXR0
aW5nLi4uXG4iKTs8YnI+KyZuYnNwOyZuYnNwOyAmbmJzcDsmbmJzcDsmbmJzcDsgJm5ic3A7ZGlz
cGxheSgiRXhlY3V0ZSBpd2N0bCB3aXRoIHJvb3QgcGVybWlzc2lvbiBpcyB0aGUgb25lIHdheSB0
byBzb2x2ZSB0aGlzIGlzc3VlLlxuIik7PGJyPiZuYnNwOzxicj4mbmJzcDsmbmJzcDsmbmJzcDsg
Jm5ic3A7Jm5ic3A7Jm5ic3A7ICZuYnNwO2dvdG8gZXJyb3I7PGJyPiZuYnNwOyZuYnNwOyZuYnNw
OyAmbmJzcDt9PGJyPjwvcD48ZGl2Pl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fPGJyPjwvZGl2PjxkaXY+aXdkIG1haWxpbmcgbGlzdCAtLSA8YSBocmVmPSJt
YWlsdG86aXdkQGxpc3RzLjAxLm9yZyI+aXdkQGxpc3RzLjAxLm9yZzwvYT48YnI+PC9kaXY+PGRp
dj5UbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIDxhIGhyZWY9Im1haWx0bzppd2QtbGVh
dmVAbGlzdHMuMDEub3JnIj5pd2QtbGVhdmVAbGlzdHMuMDEub3JnPC9hPjxicj48L2Rpdj48L2Rp
dj48L2Jsb2NrcXVvdGU+PGRpdj48YnI+PC9kaXY+PGRpdj48c3Bhbj48L3NwYW4+PC9kaXY+PC9i
b2R5PjwvaHRtbD4K

--===============0687779978371093959==--

