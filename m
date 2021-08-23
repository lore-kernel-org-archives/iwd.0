Content-Type: multipart/mixed; boundary="===============6873421750639073555=="
MIME-Version: 1.0
From: Alex Cepoi <alex.cepoi@gmail.com>
Subject: Re: Failed to connect to WPA3 network after update to iwd 1.16
Date: Mon, 23 Aug 2021 19:29:28 +0100
Message-ID: <CAJtNWJg_sp_kM_Ag0PHibv2tqjN5zMCrKJ-0aO1gfXDqU9pOtg@mail.gmail.com>
In-Reply-To: <611be548d81fd505433bca16b6bc721d8529ee68.camel@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6873421750639073555==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Router firmware should automatically update, but I can=E2=80=99t manually c=
heck for
updates.

I can confirm the current model and software version:
Model: H2D
Software version: 13729.57.19

Nothing in the way of logs though.

iwd 1.15 works totally fine for now.

Thanks for looking into it.
Alex

On Mon, 23 Aug 2021 at 18:21, James Prestwood <prestwoj@gmail.com> wrote:

> Hi Alex,
>
> On Sun, 2021-08-22 at 04:47 +0100, Alex Cepoi wrote:
>
> Hi everyone,
>
> I'm having trouble connecting to a WPA3 network after updating from 1.15
> to 1.16. Can reproduce consistently (100% success rate on 1.15, 0% success
> rate on 1.16).
>
> You can see debug logs before and after in
> https://gist.github.com/alexcepoi/eef301a56e5e40826a8a416cbfb684e6
>
> Diff shows some new "SAE Hunting and Pecking" algorithm used and a "AP did
> not include group number in response!" info, though not sure if related.
>
> I'm using a Google Nest Wifi router if that helps. I'm on Gentoo Linux (
> https://packages.gentoo.org/packages/net-wireless/iwd).
>
>
> Does the router have any logging by chance? Generally consumer devices
> don't give you much but worth a shot.
>
> Thanks,
> James
>
>

--===============6873421750639073555==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGRpdj48ZGl2IGRpcj0ibHRyIj5Sb3V0ZXIgZmlybXdhcmUgc2hvdWxkIGF1dG9tYXRpY2FsbHkg
dXBkYXRlLCBidXQgSSBjYW7igJl0IG1hbnVhbGx5IGNoZWNrIGZvciB1cGRhdGVzLjxicj48L2Rp
dj48ZGl2IGRpcj0ibHRyIj48YnI+PC9kaXY+PGRpdiBkaXI9Imx0ciI+SSBjYW4gY29uZmlybSB0
aGUgY3VycmVudCBtb2RlbCBhbmQgc29mdHdhcmUgdmVyc2lvbjo8L2Rpdj48ZGl2IGRpcj0ibHRy
Ij5Nb2RlbDogSDJE4oCoPC9kaXY+PGRpdiBkaXI9Imx0ciI+U29mdHdhcmUgdmVyc2lvbjogMTM3
MjkuNTcuMTk8L2Rpdj48ZGl2IGRpcj0ibHRyIj48YnI+PC9kaXY+PGRpdiBkaXI9Imx0ciI+Tm90
aGluZyBpbiB0aGUgd2F5IG9mIGxvZ3MgdGhvdWdoLjxicj48ZGl2IGRpcj0iYXV0byI+PGJyPjwv
ZGl2PjxkaXYgZGlyPSJhdXRvIj5pd2QgMS4xNSB3b3JrcyB0b3RhbGx5IGZpbmUgZm9yIG5vdy48
L2Rpdj48ZGl2IGRpcj0iYXV0byI+PGJyPjwvZGl2PjxkaXYgZGlyPSJhdXRvIj5UaGFua3MgZm9y
IGxvb2tpbmcgaW50byBpdC48L2Rpdj48ZGl2IGRpcj0iYXV0byI+QWxleDwvZGl2PjwvZGl2Pjwv
ZGl2PjxkaXY+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj48ZGl2IGRpcj0ibHRyIiBjbGFz
cz0iZ21haWxfYXR0ciI+T24gTW9uLCAyMyBBdWcgMjAyMSBhdCAxODoyMSwgSmFtZXMgUHJlc3R3
b29kICZsdDs8YSBocmVmPSJtYWlsdG86cHJlc3R3b2pAZ21haWwuY29tIiB0YXJnZXQ9Il9ibGFu
ayI+cHJlc3R3b2pAZ21haWwuY29tPC9hPiZndDsgd3JvdGU6PGJyPjwvZGl2PjxibG9ja3F1b3Rl
IGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3Jk
ZXItbGVmdC13aWR0aDoxcHg7Ym9yZGVyLWxlZnQtc3R5bGU6c29saWQ7cGFkZGluZy1sZWZ0OjFl
eDtib3JkZXItbGVmdC1jb2xvcjpyZ2IoMjA0LDIwNCwyMDQpIj48ZGl2PjxkaXY+SGkgQWxleCw8
L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pk9uIFN1biwgMjAyMS0wOC0yMiBhdCAwNDo0NyArMDEw
MCwgQWxleCBDZXBvaSB3cm90ZTo8L2Rpdj48YmxvY2txdW90ZSB0eXBlPSJjaXRlIiBzdHlsZT0i
bWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0LXdpZHRoOjJweDtib3JkZXItbGVm
dC1zdHlsZTpzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4O2JvcmRlci1sZWZ0LWNvbG9yOnJnYigxMTQs
MTU5LDIwNykiPjxkaXYgZGlyPSJsdHIiPkhpIGV2ZXJ5b25lLDxicj48YnI+SSYjMzk7bSBoYXZp
bmcgdHJvdWJsZSBjb25uZWN0aW5nIHRvIGEgV1BBMyBuZXR3b3JrIGFmdGVyIHVwZGF0aW5nIGZy
b20gMS4xNSB0byAxLjE2LiBDYW4gcmVwcm9kdWNlIGNvbnNpc3RlbnRseSAoMTAwJSBzdWNjZXNz
IHJhdGUgb24gMS4xNSwgMCUgc3VjY2VzcyByYXRlIG9uIDEuMTYpLjxicj48YnI+WW91IGNhbiBz
ZWUgZGVidWcgbG9ncyBiZWZvcmUgYW5kIGFmdGVyIGluIDxhIGhyZWY9Imh0dHBzOi8vZ2lzdC5n
aXRodWIuY29tL2FsZXhjZXBvaS9lZWYzMDFhNTZlNWU0MDgyNmE4YTQxNmNiZmI2ODRlNiIgdGFy
Z2V0PSJfYmxhbmsiPmh0dHBzOi8vZ2lzdC5naXRodWIuY29tL2FsZXhjZXBvaS9lZWYzMDFhNTZl
NWU0MDgyNmE4YTQxNmNiZmI2ODRlNjwvYT48YnI+PGJyPkRpZmYgc2hvd3Mgc29tZSBuZXcgJnF1
b3Q7U0FFIEh1bnRpbmcgYW5kIFBlY2tpbmcmcXVvdDsgYWxnb3JpdGhtIHVzZWQgYW5kIGEgJnF1
b3Q7QVAgZGlkIG5vdCBpbmNsdWRlIGdyb3VwIG51bWJlciBpbiByZXNwb25zZSEmcXVvdDsgaW5m
bywgdGhvdWdoIG5vdCBzdXJlIGlmIHJlbGF0ZWQuPGJyPjxicj5JJiMzOTttIHVzaW5nIGEgR29v
Z2xlIE5lc3QgV2lmaSByb3V0ZXIgaWYgdGhhdCBoZWxwcy4gSSYjMzk7bSBvbiBHZW50b28gTGlu
dXggKDxhIGhyZWY9Imh0dHBzOi8vcGFja2FnZXMuZ2VudG9vLm9yZy9wYWNrYWdlcy9uZXQtd2ly
ZWxlc3MvaXdkIiB0YXJnZXQ9Il9ibGFuayI+aHR0cHM6Ly9wYWNrYWdlcy5nZW50b28ub3JnL3Bh
Y2thZ2VzL25ldC13aXJlbGVzcy9pd2Q8L2E+KS48L2Rpdj48L2Jsb2NrcXVvdGU+PGRpdj48YnI+
PC9kaXY+PGRpdj5Eb2VzIHRoZSByb3V0ZXIgaGF2ZSBhbnkgbG9nZ2luZyBieSBjaGFuY2U/IEdl
bmVyYWxseSBjb25zdW1lciBkZXZpY2VzIGRvbiYjMzk7dCBnaXZlIHlvdSBtdWNoIGJ1dCB3b3J0
aCBhIHNob3QuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5UaGFua3MsPC9kaXY+PGRpdj5KYW1l
czwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PHNwYW4+PC9zcGFuPjwvZGl2PjwvZGl2Pgo8L2Js
b2NrcXVvdGU+PC9kaXY+CjwvZGl2Pgo=

--===============6873421750639073555==--

