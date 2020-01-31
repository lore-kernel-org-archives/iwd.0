Content-Type: multipart/mixed; boundary="===============4380801441764027317=="
MIME-Version: 1.0
From: Kourt, Tim A <tim.a.kourt@intel.com>
Subject: Re: Issue connecting to PEAP (eduroam)
Date: Fri, 31 Jan 2020 17:20:07 +0000
Message-ID: <B16985CA-6F78-4207-B44F-426032177244@intel.com>
In-Reply-To: <20200131111151.2820.65195@ml01.vlan13.01.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4380801441764027317==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

=EF=BB=BF-----Original Message-----
From: "abagnale20(a)protonmail.com" <abagnale20@protonmail.com>
Date: Friday, January 31, 2020 at 3:09 AM
To: "iwd(a)lists.01.org" <iwd@lists.01.org>
Subject: Issue connecting to PEAP (eduroam)

    =

    4-Way handshake failed for ifindex: 2, reason: 15
    =

    What is reason 15?
The reason 15 is timeout. This is just a consequence of the failed/aborted =
authentication that should have been in the log above these lines. The full=
 iwd log and iwmon output can be helpful to identify the cause of the faile=
d authentication. You may refer to https://iwd.wiki.kernel.org/debugging fo=
r the reference on how to obtain the logs.

Regards,
Tim


--===============4380801441764027317==--

