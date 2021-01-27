Content-Type: multipart/mixed; boundary="===============0885720310611816723=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: Re: [PATCH 1/5] auto-t: add test for roaming retry timing
Date: Wed, 27 Jan 2021 11:21:41 -0800
Message-ID: <ce82111dbd937b9b0bd11945f8486a5d582ef8e1.camel@gmail.com>
In-Reply-To: <20210127100457.341757-1-alsi@bang-olufsen.dk>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0885720310611816723==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alvin,

Looks like this already got applied as I was writing but...

<snip>

> diff --git a/autotests/testRoamRetry/hw.conf
> b/autotests/testRoamRetry/hw.conf
> new file mode 100644
> index 00000000..5dbe97b4
> --- /dev/null
> +++ b/autotests/testRoamRetry/hw.conf
> @@ -0,0 +1,7 @@
> +[SETUP]
> +num_radios=3D3
> +needs_hwsim=3D1

'needs_hwsim' is no longer required (yes, I know lots of tests still
have this). test-runner assumes hwsim is being used unless
'hwsim_medium=3Dno' is found. I need to take some time and remove this
along with several other stale options. Ill remove this for you since
it was already applied.

Thanks,
James


--===============0885720310611816723==--

