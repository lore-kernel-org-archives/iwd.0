Content-Type: multipart/mixed; boundary="===============5792619814923260248=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH] network: Hide hidden networks on passphrase error
Date: Wed, 09 Mar 2022 10:22:07 -0600
Message-ID: <472469a5-00e9-babe-4129-5f1c0971c841@gmail.com>
In-Reply-To: MRZP264MB15442847B0DE53B9886299DE930A9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM

--===============5792619814923260248==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Emmanuel,

>> Alternatively, we could somehow mark these networks non-connectable unle=
ss
>> they're done via the ConnectHiddenNetwork() path.
> I was also thinking about this possibility. Do you think that the hidden =
network shall also
> be removed if an error occurs during connection, for example in station_c=
onnect_cb?

Actually, that is a good point.  We do not hide the hidden network in this =
case. =

  It sort of depends on what we want to do about this.  Some possible strat=
egies =

would be:

When ConnectHiddenNetwork is invoked (in the scan results callback), mark t=
he =

network as 'provisioning-hidden'.

1. On a passphrase failure, or connect failure wipe it from the scan result =

cache, per your proposal.

2. Leave the network in the cache on failure, allow the scan-results to be =

re-used for subsequent ConnectHiddenNetwork calls.  Disallow Network.Connec=
t() =

call if the 'provisioning-hidden' flag is set on the network.

3. Similar to 2, but allow Network.Connect() to proceed normally and simply=
 set =

the NET_HIDDEN value based on the 'provisioning-hidden' flag.

Approach 2 & 3 avoids unnecessary scanning in case the user enters the wron=
g =

password.  On the other hand, approach 1 ensures there's no temporary netwo=
rk =

left around on failure and that seems a bit cleaner.

Do note that in all cases we still end up creating a temporary Network obje=
ct =

while the connection is in progress.  And in theory Network.Connect could b=
e =

invoked on that object, but it would bounce with an InProgress error.

Regards,
-Denis
--===============5792619814923260248==--

