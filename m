Content-Type: multipart/mixed; boundary="===============0657452682212758911=="
MIME-Version: 1.0
From: KeithG <ys3al35l@gmail.com>
Subject: Re: iwd not connecting on Raspberry Pi with Raspbian
Date: Sat, 29 Aug 2020 12:22:54 -0500
Message-ID: <CAG17S_N3QGFXQwj1GnM58Xr9jsuQzY9-bLvfaJJEbkGCNfbdDw@mail.gmail.com>
In-Reply-To: <2521561.bxObpI80mx@mmm>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0657452682212758911==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

You may need to remove wpa_supplicant. I have it removed from my images.

On Sat, Aug 29, 2020, 12:20 Patrick H=C3=A4cker <pat_h@web.de> wrote:

> Hi Keith,
>
> thanks for answering, I really appreciate it.
>
> > I run iwd on RPi, but I am using Arch Linux. I've never tried it with
> > RaspiOS. Works pretty well, though I am having a re-connect issue that =
we
> > are trying to debug.
> Knowing that, it's likely, that it's a problem due to the Raspbian
> configuration or the specific iwd / network environment combination.
>
> > My guess is that you compiled the kernel to remove this message in the
> log:
> >
> > Aug 23 22:52:24 rune64 iwd[235]: No Diffie-Hellman support found, WPS
> will
> > not be available
> > Aug 23 22:52:24 rune64 iwd[235]: The following options are missing in t=
he
> > kernel:
> > Aug 23 22:52:24 rune64 iwd[235]:         CONFIG_KEY_DH_OPERATIONS
> >
> > This is harmless and I have no problems connecting with this
> notification.
> > I think it means I cannot use WPS which I do not.
> Yes exactly, I had this message, and although I do not use WPS I thought
> it
> would be worth a try. But whether that option is included in the kernel or
> not
> does not make a difference.
>
> > Are you trying to connect using the iwctl commands?
> >
> > iwctl station wlan0 scan
> > iwctl station wlan0 get-networks
> > iwctl station wlan0 connect 'Network_Name"
> >
> > It should return with
> >
> > Type the network passphrase for "Network_Name" psk.
> > Passphrase: ********
> Yes, these were my first tests. However, few seconds after entering the
> Passphrase I always get a red "Operation failed".
> Therefore, I manually created correct psk files in /var/lib/iwd (I know
> they
> are correct, as they work on another computer in the same network).
> However
> that was not successful (but I used this configuration for creating the
> debug
> output, as it's simpler not having to type the password).
>
> > or are you using connman to manage iwd?
> No I am testing iwd directly. Currently I let systemd-networkd manage the
> network interface. But without being connected with iwd this obviously
> fails
> (however it works when using wpa_supplicant).
>
> > Do you have an /etc/iwd/main.conf? If so, what is in it?
> No, I am not using a config file.
>
> > I assume you have enabled and started iwd.
> In general yes, but for testing I sometimes disable it in systemd and
> start it
> manually. But neither mode works.
>
> I created an strace, but it didn't enlighten me. The bad file descriptor
> does
> not look good, but is probably due to the deauthentication event and not
> the
> other way round.
> > recvmsg(5, {msg_name=3DNULL, msg_namelen=3D0, msg_iov=3D[{iov_base=3D
> >
>  "D\0\0\0\20\0\0\0\0\0\0\0\0\0\0\0\0\0\1\0\3\0\0\0\3\20\0\0\0\0\0\0"...,
> >     iov_len=3D4096}], msg_iovlen=3D1, msg_control=3D[{cmsg_len=3D16,
> >     cmsg_level=3DSOL_NETLINK, cmsg_type=3D0x3}], msg_controllen=3D16,
> msg_flags=3D0},
> >     0) =3D 68
> > recvmsg(4, {msg_name=3DNULL, msg_namelen=3D0,  msg_iov=3D[{iov_base=3D
> >
> "0\0\0\0\27\0\0\0\0\0\0\0\0\0\0\0000\1\0\0\10\0\1\0\0\0\0\0\10\0\3\0"...,
> >     iov_len=3D8192}], msg_iovlen=3D1, msg_control=3D[{cmsg_len=3D16,
> >     cmsg_level=3DSOL_NETLINK, cmsg_type=3D0x3}], msg_controllen=3D16,
> msg_flags=3D0},
> > 0) =3D 48
> > write(2, "Received Deauthentication event,"..., 59) =3D 59
> > close(12)                               =3D 0
> > epoll_ctl(3, EPOLL_CTL_DEL, 12, NULL)   =3D -1 EBADF (Bad file descript=
or)
>
> Any more ideas how to debug this, anyone?  Is it possible to run an Arch
> kernel on a Raspbian?
>
> Kind regards
> Patrick

--===============0657452682212758911==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGRpdiBkaXI9ImF1dG8iPllvdSBtYXkgbmVlZCB0byByZW1vdmUgd3BhX3N1cHBsaWNhbnQuIEkg
aGF2ZSBpdCByZW1vdmVkIGZyb20gbXkgaW1hZ2VzLjwvZGl2Pjxicj48ZGl2IGNsYXNzPSJnbWFp
bF9xdW90ZSI+PGRpdiBkaXI9Imx0ciIgY2xhc3M9ImdtYWlsX2F0dHIiPk9uIFNhdCwgQXVnIDI5
LCAyMDIwLCAxMjoyMCBQYXRyaWNrIEjDpGNrZXIgJmx0OzxhIGhyZWY9Im1haWx0bzpwYXRfaEB3
ZWIuZGUiPnBhdF9oQHdlYi5kZTwvYT4mZ3Q7IHdyb3RlOjxicj48L2Rpdj48YmxvY2txdW90ZSBj
bGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDox
cHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij5IaSBLZWl0aCw8YnI+Cjxicj4KdGhhbmtz
IGZvciBhbnN3ZXJpbmcsIEkgcmVhbGx5IGFwcHJlY2lhdGUgaXQuPGJyPgo8YnI+CiZndDsgSSBy
dW4gaXdkIG9uIFJQaSwgYnV0IEkgYW0gdXNpbmcgQXJjaCBMaW51eC4gSSYjMzk7dmUgbmV2ZXIg
dHJpZWQgaXQgd2l0aDxicj4KJmd0OyBSYXNwaU9TLiBXb3JrcyBwcmV0dHkgd2VsbCwgdGhvdWdo
IEkgYW0gaGF2aW5nIGEgcmUtY29ubmVjdCBpc3N1ZSB0aGF0IHdlPGJyPgomZ3Q7IGFyZSB0cnlp
bmcgdG8gZGVidWcuPGJyPgpLbm93aW5nIHRoYXQsIGl0JiMzOTtzIGxpa2VseSwgdGhhdCBpdCYj
Mzk7cyBhIHByb2JsZW0gZHVlIHRvIHRoZSBSYXNwYmlhbiA8YnI+CmNvbmZpZ3VyYXRpb24gb3Ig
dGhlIHNwZWNpZmljIGl3ZCAvIG5ldHdvcmsgZW52aXJvbm1lbnQgY29tYmluYXRpb24uPGJyPgo8
YnI+CiZndDsgTXkgZ3Vlc3MgaXMgdGhhdCB5b3UgY29tcGlsZWQgdGhlIGtlcm5lbCB0byByZW1v
dmUgdGhpcyBtZXNzYWdlIGluIHRoZSBsb2c6PGJyPgomZ3Q7IDxicj4KJmd0OyBBdWcgMjMgMjI6
NTI6MjQgcnVuZTY0IGl3ZFsyMzVdOiBObyBEaWZmaWUtSGVsbG1hbiBzdXBwb3J0IGZvdW5kLCBX
UFMgd2lsbDxicj4KJmd0OyBub3QgYmUgYXZhaWxhYmxlPGJyPgomZ3Q7IEF1ZyAyMyAyMjo1Mjoy
NCBydW5lNjQgaXdkWzIzNV06IFRoZSBmb2xsb3dpbmcgb3B0aW9ucyBhcmUgbWlzc2luZyBpbiB0
aGU8YnI+CiZndDsga2VybmVsOjxicj4KJmd0OyBBdWcgMjMgMjI6NTI6MjQgcnVuZTY0IGl3ZFsy
MzVdOsKgIMKgIMKgIMKgIMKgQ09ORklHX0tFWV9ESF9PUEVSQVRJT05TPGJyPgomZ3Q7IDxicj4K
Jmd0OyBUaGlzIGlzIGhhcm1sZXNzIGFuZCBJIGhhdmUgbm8gcHJvYmxlbXMgY29ubmVjdGluZyB3
aXRoIHRoaXMgbm90aWZpY2F0aW9uLjxicj4KJmd0OyBJIHRoaW5rIGl0IG1lYW5zIEkgY2Fubm90
IHVzZSBXUFMgd2hpY2ggSSBkbyBub3QuPGJyPgpZZXMgZXhhY3RseSwgSSBoYWQgdGhpcyBtZXNz
YWdlLCBhbmQgYWx0aG91Z2ggSSBkbyBub3QgdXNlIFdQUyBJIHRob3VnaHQgaXQgPGJyPgp3b3Vs
ZCBiZSB3b3J0aCBhIHRyeS4gQnV0IHdoZXRoZXIgdGhhdCBvcHRpb24gaXMgaW5jbHVkZWQgaW4g
dGhlIGtlcm5lbCBvciBub3QgPGJyPgpkb2VzIG5vdCBtYWtlIGEgZGlmZmVyZW5jZS48YnI+Cjxi
cj4KJmd0OyBBcmUgeW91IHRyeWluZyB0byBjb25uZWN0IHVzaW5nIHRoZSBpd2N0bCBjb21tYW5k
cz88YnI+CiZndDsgPGJyPgomZ3Q7IGl3Y3RsIHN0YXRpb24gd2xhbjAgc2Nhbjxicj4KJmd0OyBp
d2N0bCBzdGF0aW9uIHdsYW4wIGdldC1uZXR3b3Jrczxicj4KJmd0OyBpd2N0bCBzdGF0aW9uIHds
YW4wIGNvbm5lY3QgJiMzOTtOZXR3b3JrX05hbWUmcXVvdDs8YnI+CiZndDsgPGJyPgomZ3Q7IEl0
IHNob3VsZCByZXR1cm4gd2l0aDxicj4KJmd0OyA8YnI+CiZndDsgVHlwZSB0aGUgbmV0d29yayBw
YXNzcGhyYXNlIGZvciAmcXVvdDtOZXR3b3JrX05hbWUmcXVvdDsgcHNrLjxicj4KJmd0OyBQYXNz
cGhyYXNlOiAqKioqKioqKjxicj4KWWVzLCB0aGVzZSB3ZXJlIG15IGZpcnN0IHRlc3RzLiBIb3dl
dmVyLCBmZXcgc2Vjb25kcyBhZnRlciBlbnRlcmluZyB0aGUgPGJyPgpQYXNzcGhyYXNlIEkgYWx3
YXlzIGdldCBhIHJlZCAmcXVvdDtPcGVyYXRpb24gZmFpbGVkJnF1b3Q7Ljxicj4KVGhlcmVmb3Jl
LCBJIG1hbnVhbGx5IGNyZWF0ZWQgY29ycmVjdCBwc2sgZmlsZXMgaW4gL3Zhci9saWIvaXdkIChJ
IGtub3cgdGhleSA8YnI+CmFyZSBjb3JyZWN0LCBhcyB0aGV5IHdvcmsgb24gYW5vdGhlciBjb21w
dXRlciBpbiB0aGUgc2FtZSBuZXR3b3JrKS4gSG93ZXZlciA8YnI+CnRoYXQgd2FzIG5vdCBzdWNj
ZXNzZnVsIChidXQgSSB1c2VkIHRoaXMgY29uZmlndXJhdGlvbiBmb3IgY3JlYXRpbmcgdGhlIGRl
YnVnIDxicj4Kb3V0cHV0LCBhcyBpdCYjMzk7cyBzaW1wbGVyIG5vdCBoYXZpbmcgdG8gdHlwZSB0
aGUgcGFzc3dvcmQpLjxicj4KPGJyPgomZ3Q7IG9yIGFyZSB5b3UgdXNpbmcgY29ubm1hbiB0byBt
YW5hZ2UgaXdkPzxicj4KTm8gSSBhbSB0ZXN0aW5nIGl3ZCBkaXJlY3RseS4gQ3VycmVudGx5IEkg
bGV0IHN5c3RlbWQtbmV0d29ya2QgbWFuYWdlIHRoZSA8YnI+Cm5ldHdvcmsgaW50ZXJmYWNlLiBC
dXQgd2l0aG91dCBiZWluZyBjb25uZWN0ZWQgd2l0aCBpd2QgdGhpcyBvYnZpb3VzbHkgZmFpbHMg
PGJyPgooaG93ZXZlciBpdCB3b3JrcyB3aGVuIHVzaW5nIHdwYV9zdXBwbGljYW50KS48YnI+Cjxi
cj4KJmd0OyBEbyB5b3UgaGF2ZSBhbiAvZXRjL2l3ZC9tYWluLmNvbmY/IElmIHNvLCB3aGF0IGlz
IGluIGl0Pzxicj4KTm8sIEkgYW0gbm90IHVzaW5nIGEgY29uZmlnIGZpbGUuPGJyPgo8YnI+CiZn
dDsgSSBhc3N1bWUgeW91IGhhdmUgZW5hYmxlZCBhbmQgc3RhcnRlZCBpd2QuPGJyPgpJbiBnZW5l
cmFsIHllcywgYnV0IGZvciB0ZXN0aW5nIEkgc29tZXRpbWVzIGRpc2FibGUgaXQgaW4gc3lzdGVt
ZCBhbmQgc3RhcnQgaXQgPGJyPgptYW51YWxseS4gQnV0IG5laXRoZXIgbW9kZSB3b3Jrcy48YnI+
Cjxicj4KSSBjcmVhdGVkIGFuIHN0cmFjZSwgYnV0IGl0IGRpZG4mIzM5O3QgZW5saWdodGVuIG1l
LiBUaGUgYmFkIGZpbGUgZGVzY3JpcHRvciBkb2VzIDxicj4Kbm90IGxvb2sgZ29vZCwgYnV0IGlz
IHByb2JhYmx5IGR1ZSB0byB0aGUgZGVhdXRoZW50aWNhdGlvbiBldmVudCBhbmQgbm90IHRoZSA8
YnI+Cm90aGVyIHdheSByb3VuZC48YnI+CiZndDsgcmVjdm1zZyg1LCB7bXNnX25hbWU9TlVMTCwg
bXNnX25hbWVsZW49MCwgbXNnX2lvdj1be2lvdl9iYXNlPTxicj4KJmd0O8KgIMKgIMKgJnF1b3Q7
RFwwXDBcMFwyMFwwXDBcMFwwXDBcMFwwXDBcMFwwXDBcMFwwXDFcMFwzXDBcMFwwXDNcMjBcMFww
XDBcMFwwXDAmcXVvdDsuLi4sPGJyPgomZ3Q7wqAgwqAgwqBpb3ZfbGVuPTQwOTZ9XSwgbXNnX2lv
dmxlbj0xLCBtc2dfY29udHJvbD1be2Ntc2dfbGVuPTE2LCA8YnI+CiZndDvCoCDCoCDCoGNtc2df
bGV2ZWw9U09MX05FVExJTkssIGNtc2dfdHlwZT0weDN9XSwgbXNnX2NvbnRyb2xsZW49MTYsIG1z
Z19mbGFncz0wfSw8YnI+CiZndDvCoCDCoCDCoDApID0gNjg8YnI+CiZndDsgcmVjdm1zZyg0LCB7
bXNnX25hbWU9TlVMTCwgbXNnX25hbWVsZW49MCzCoCBtc2dfaW92PVt7aW92X2Jhc2U9PGJyPgom
Z3Q7wqAgwqAgJnF1b3Q7MFwwXDBcMFwyN1wwXDBcMFwwXDBcMFwwXDBcMFwwXDAwMDBcMVwwXDBc
MTBcMFwxXDBcMFwwXDBcMFwxMFwwXDNcMCZxdW90Oy4uLiw8YnI+CiZndDvCoCDCoCDCoGlvdl9s
ZW49ODE5Mn1dLCBtc2dfaW92bGVuPTEsIG1zZ19jb250cm9sPVt7Y21zZ19sZW49MTYsPGJyPgom
Z3Q7wqAgwqAgwqBjbXNnX2xldmVsPVNPTF9ORVRMSU5LLCBjbXNnX3R5cGU9MHgzfV0sIG1zZ19j
b250cm9sbGVuPTE2LCBtc2dfZmxhZ3M9MH0sPGJyPgomZ3Q7IDApID0gNDggPGJyPgomZ3Q7IHdy
aXRlKDIsICZxdW90O1JlY2VpdmVkIERlYXV0aGVudGljYXRpb24gZXZlbnQsJnF1b3Q7Li4uLCA1
OSkgPSA1OTxicj4KJmd0OyBjbG9zZSgxMinCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoD0gMDxicj4KJmd0OyBlcG9sbF9jdGwoMywgRVBPTExfQ1RMX0RFTCwg
MTIsIE5VTEwpwqAgwqA9IC0xIEVCQURGIChCYWQgZmlsZSBkZXNjcmlwdG9yKSA8YnI+Cjxicj4K
QW55IG1vcmUgaWRlYXMgaG93IHRvIGRlYnVnIHRoaXMsIGFueW9uZT/CoCBJcyBpdCBwb3NzaWJs
ZSB0byBydW4gYW4gQXJjaCA8YnI+Cmtlcm5lbCBvbiBhIFJhc3BiaWFuPzxicj4KPGJyPgpLaW5k
IHJlZ2FyZHM8YnI+ClBhdHJpY2s8L2Jsb2NrcXVvdGU+PC9kaXY+Cg==

--===============0657452682212758911==--

