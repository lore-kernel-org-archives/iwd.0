Content-Type: multipart/mixed; boundary="===============7509749312956638897=="
MIME-Version: 1.0
From: Patrick =?unknown-8bit?q?H=C3=A4cker?= <pat_h@web.de>
Subject: Re: iwd not connecting on Raspberry Pi with Raspbian
Date: Sat, 29 Aug 2020 19:20:25 +0200
Message-ID: <2521561.bxObpI80mx@mmm>
In-Reply-To: <CAG17S_NOvdFCKmyZSxhLCzNvS=yv9fCTNpnrzT4gLARY=rx+qg@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7509749312956638897==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Keith,

thanks for answering, I really appreciate it.

> I run iwd on RPi, but I am using Arch Linux. I've never tried it with
> RaspiOS. Works pretty well, though I am having a re-connect issue that we
> are trying to debug.
Knowing that, it's likely, that it's a problem due to the Raspbian =

configuration or the specific iwd / network environment combination.

> My guess is that you compiled the kernel to remove this message in the lo=
g:
> =

> Aug 23 22:52:24 rune64 iwd[235]: No Diffie-Hellman support found, WPS will
> not be available
> Aug 23 22:52:24 rune64 iwd[235]: The following options are missing in the
> kernel:
> Aug 23 22:52:24 rune64 iwd[235]:         CONFIG_KEY_DH_OPERATIONS
> =

> This is harmless and I have no problems connecting with this notification.
> I think it means I cannot use WPS which I do not.
Yes exactly, I had this message, and although I do not use WPS I thought it =

would be worth a try. But whether that option is included in the kernel or =
not =

does not make a difference.

> Are you trying to connect using the iwctl commands?
> =

> iwctl station wlan0 scan
> iwctl station wlan0 get-networks
> iwctl station wlan0 connect 'Network_Name"
> =

> It should return with
> =

> Type the network passphrase for "Network_Name" psk.
> Passphrase: ********
Yes, these were my first tests. However, few seconds after entering the =

Passphrase I always get a red "Operation failed".
Therefore, I manually created correct psk files in /var/lib/iwd (I know the=
y =

are correct, as they work on another computer in the same network). However =

that was not successful (but I used this configuration for creating the deb=
ug =

output, as it's simpler not having to type the password).

> or are you using connman to manage iwd?
No I am testing iwd directly. Currently I let systemd-networkd manage the =

network interface. But without being connected with iwd this obviously fail=
s =

(however it works when using wpa_supplicant).

> Do you have an /etc/iwd/main.conf? If so, what is in it?
No, I am not using a config file.

> I assume you have enabled and started iwd.
In general yes, but for testing I sometimes disable it in systemd and start=
 it =

manually. But neither mode works.

I created an strace, but it didn't enlighten me. The bad file descriptor do=
es =

not look good, but is probably due to the deauthentication event and not th=
e =

other way round.
> recvmsg(5, {msg_name=3DNULL, msg_namelen=3D0, msg_iov=3D[{iov_base=3D
>     "D\0\0\0\20\0\0\0\0\0\0\0\0\0\0\0\0\0\1\0\3\0\0\0\3\20\0\0\0\0\0\0"..=
.,
>     iov_len=3D4096}], msg_iovlen=3D1, msg_control=3D[{cmsg_len=3D16,=00
>     cmsg_level=3DSOL_NETLINK, cmsg_type=3D0x3}], msg_controllen=3D16, msg=
_flags=3D0},
>     0) =3D 68
> recvmsg(4, {msg_name=3DNULL, msg_namelen=3D0,=00 msg_iov=3D[{iov_base=3D
>    "0\0\0\0\27\0\0\0\0\0\0\0\0\0\0\0000\1\0\0\10\0\1\0\0\0\0\0\10\0\3\0".=
..,
>     iov_len=3D8192}], msg_iovlen=3D1, msg_control=3D[{cmsg_len=3D16,
>     cmsg_level=3DSOL_NETLINK, cmsg_type=3D0x3}], msg_controllen=3D16, msg=
_flags=3D0},
> 0) =3D 48=00
> write(2, "Received Deauthentication event,"..., 59) =3D 59
> close(12)                               =3D 0
> epoll_ctl(3, EPOLL_CTL_DEL, 12, NULL)   =3D -1 EBADF (Bad file descriptor=
)=00

Any more ideas how to debug this, anyone?  Is it possible to run an Arch =

kernel on a Raspbian?

Kind regards
Patrick

--===============7509749312956638897==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSXpCQUFCQ2dBZEZpRUU4Sm9qVkkrY0ZY
MWsxRTdZSEdndTErVEpCZUFGQWw5S2psa0FDZ2tRSEdndTErVEoKQmVCVndnLytMby9iUkl2bllT
dTA4bEJsVFdadEVWdm9XUE9YNjJ0bklvR2tHeTVNYTZLNmNsUUxDTTFrTk9POQp3akZWa2loZjhG
KzRCQlhVNmhiODhyS0huNURFTzJnRjhJQWJGSzVpQlVSMzFKS09VTVdUblU3Z0ZKUHJSZlRxCkFj
emhlQWMxQjd6V3RXQUVIWlVnOWpPKzljSU5ZS3E2U1c4RDltSGtQaCtURTBlRWVJNFFMZ1ptNHh5
dGoyRm0KL2IxbEljZE9lOC9mSU9MVERGdDlKYXo5cnh3SnhnOXBtM2NXcjNSa1ZydVI1dTE1NGJC
UE1vVzVOMDFsWkdpagpaUGVjOHRFRFQ3MUlFMzJJcU8wdXQvRDhuLzVoQmtJY0VJY1diRWJXYldr
QlJnNGc1clZmZmk1cHE2TU1JbTRhCnU0akJQVXZsejg5WDZIQ2RLQ3J5QnViZVNhWG5qejFkMkxv
WUZSb3VoMXVLUk9xczYvOWFsM2NWQWxRVHllbGgKMVdJQ1VDQ1FxSmkweTQyNTgwZDdxcklVWk9q
ZWZqWitTVzlrZ3d3LzRTRUhHaElYR0pVelZzNXFGR25CY0MxRwpDcGdrZmhCbWF1Ri85YnRNVUZP
TWJWUFNETHViN3RJN0cwM3RtelRFSjhrNzF2QzJpaEt0K25CN0htTkt2bDYxCk9STFlEZGdDT3JO
WENoWTUrcjJ0cHBYUHk1eXNYK0NxdElkNTE4dVZURXNGOURZNmNYQ2w0UDNxT25JQ3lJZ3kKQjJ6
d1FlZmNDcnczblozWmk2NDlMYitGSCs3R0JUSmdKWTdaYnJNd2dlWW5FWjlqN1Y1V2RzMGZoa0k2
bGRkTgpFczgrclg0L0VnNlgzRG9DV2trbFV1QlIxM1lveVd3bnM2enVXVll6VzhhWHdrT0JDOFE9
Cj04bHF6Ci0tLS0tRU5EIFBHUCBTSUdOQVRVUkUtLS0tLQo=

--===============7509749312956638897==--

