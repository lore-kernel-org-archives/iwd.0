Content-Type: multipart/mixed; boundary="===============3600237634892136395=="
MIME-Version: 1.0
From: Altous, Salahaldeen <Salahaldeen.Altous@leica-camera.com>
Subject: Re: iwd as AP "Couldn't connect to network"
Date: Wed, 07 Apr 2021 09:29:37 +0000
Message-ID: <f40d0d8e27f8f62fd4f6851ea67b816fe9f26335.camel@leica-camera.com>
In-Reply-To: <cfaa7b3e-1451-eed7-491e-26b07be62d85@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3600237634892136395==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Tue, 2021-04-06 at 11:23 -0500, Denis Kenzior wrote:
> Hi Salahaldeen,
>
> On 4/6/21 4:41 AM, Altous, Salahaldeen wrote:
> > Hi everyone!
> >
> > I am running iwd 1.9 (dunfell Yocto Project 3.1) with ell 0.33 with
> > Linux kernel 4.4.236.
>
> This version is quite old, can you upgrade to 1.13 ?
I have tried to update to iwd 1.12 and ell 0.38 but I have problem with
starting iwd (Module ap failed to start: -22). I have not seen this
error with iwd 1.9.
Where I can find the known frequency file?

../git/src/knownnetworks.c:known_network_frequencies_load() No known
frequency file found.
Module ap failed to start: -22
../git/src/module.c:iwd_modules_exit()
../git/src/wsc.c:wsc_exit()
D-Bus disconnected, quitting...

updating Linux kernel to a new version is not possible but I am using
the lastest 4.4 LTS updates.
>
> > when I try to start iwd in AP mode (ap wlan0 start myssid
> > mypassword
> > ) and try to establish a connection to my AP I get the error
> > "Couldn't
> > connect to network"
> >
>
> What hardware are you running?  Is it Broadcom by any chance?  If so,
> you need
> iwd version >=3D 1.12 for AP mode to work.
>
We are using a qualcom chip not broadcom
> Regards,
> -Denis

Regards,
Salahaldeen
Leica Camera AG | Registergericht | District Court of Wetzlar: HRB966
Vorstand | Executive Board: Matthias Harsch (Vorsitzender) | Dr. Marita Paa=
sch
Aufsichtsratsvorsitzender | Chairman of the Supervisory Board: Dr. Andreas =
Kaufmann

This message may contain confidential and privileged information. If it has=
 been sent to you in error, please notify the sender immediately by replyin=
g to the message and please delete it from your computer.

--===============3600237634892136395==--

