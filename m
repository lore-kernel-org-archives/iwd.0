Content-Type: multipart/mixed; boundary="===============7843364136531297900=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: Re: iwd 1.21 stuck on connecting state
Date: Mon, 31 Jan 2022 14:15:41 -0800
Message-ID: <693ddbdafd550d947e1e9a2e4e36685a9a0de4c2.camel@gmail.com>
In-Reply-To: 20220129200358.2828.46152@ml01.vlan13.01.org

--===============7843364136531297900==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, 2022-01-29 at 20:03 +0000,
54d22547-afc0-4701-b1fc-5a2a2e411646(a)simplelogin.co wrote:
> Sorry, didn't know that. I reproduced the problem again and uploaded
> the file here: https://transfer.sh/get/jiEvOg/dhcp.pcap
> =

> Hope this helps!

Below is a patch for ELL [1]. If its possible for you to apply it and
rebuild both IWD/ELL manually to test that would be great. The issue
should be solved but you will see an additional print when you normally
would see IWD hang and never get connected:

"Server sent another offer, using it instead"

Note: IWD_DHCP_DEBUG has to be enabled to see this.

If you are able to get a log showing this behavior we can mark this as
fixed, otherwise we can wait till this patch is in a release and see if
it fixed the issue then. Thanks for your help so far.

[1]
https://lists.01.org/hyperkitty/list/ell(a)lists.01.org/thread/DJHXIOGGOCGG=
FUD2E3N2XVXCUAO2X2UP/

> _______________________________________________
> iwd mailing list -- iwd(a)lists.01.org
> To unsubscribe send an email to iwd-leave(a)lists.01.org


--===============7843364136531297900==--

