Content-Type: multipart/mixed; boundary="===============3310735003318058012=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: iwd 1.8 causes kernel oops
Date: Tue, 23 Jun 2020 13:29:04 -0500
Message-ID: <e7bcbdb0-2642-4cad-2888-65855701a83c@gmail.com>
In-Reply-To: <20200623110941.2644.7970@ml01.vlan13.01.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3310735003318058012==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 6/23/20 6:09 AM, caljorden(a)hotmail.com wrote:
> Hi all,
> =

> I have observed on my two main machines that I am getting a kernel oops w=
hen I boot that only occurs when I am running IWD 1.8.  When I downgrade to=
 IWD 1.7, the oops goes away.  I have observed this on kernels 5.7.4 and 5.=
7.5 (at least).  The kernel oops does not seem to negatively impact the ope=
ration of the system, and wireless works fine after this as well.

Funny.  Seems to happen somewhere in NL80211_CMD_GET_REG processing in the =
kernel.

Can you try running something like:
'iw phy phy0 reg get' and see if the kernel crashes?

> I have tried to run the current git master branch (currently f7c036a80182=
13d3b8ce3fe36fdceeb633c00c54), but I can't get iwd to start on that commit =
(it just exits with a non-zero return.  I tried to strace it, and it seems =
to be having some issue with accessing the kernel keystore, maybe?)

Ah I fixed this now.  But I git master won't help you with the kernel crash=
. =

You should report this as a bug to the kernel folks.

Regards,
-Denis
--===============3310735003318058012==--

