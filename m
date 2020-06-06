Content-Type: multipart/mixed; boundary="===============3756360189824477651=="
MIME-Version: 1.0
From: Alvin =?unknown-8bit?q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>
Subject: Re: [PATCH v2 1/2] scan: refactor start_next_scan_request to not send
 duplicate requests
Date: Sat, 06 Jun 2020 19:33:09 +0200
Message-ID: <f4f06da6-647a-3cb3-d4f1-73bc79761fc1@bang-olufsen.dk>
In-Reply-To: <053d938e-c873-79f1-ca84-020af2e2f285@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3756360189824477651==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew and Denis,

Thanks for your comments.

On 6/4/20 8:31 PM, Denis Kenzior wrote:
>> In this case, the first callback to scan_request_triggered() will delete
>> the request from the scan request queue. The second callback will find
>> an empty queue and consequently pass a NULL scan_request pointer to
>> scan_request_failed(), causing a segmentation fault.
> =

> So for my own education, can you elaborate a bit more on how this is
> actually triggered?=C2=A0 I'm guessing that there are pending scans (prob=
ably
> triggered by invocation of Scan() via D-Bus?).=C2=A0 But an exact sequenc=
e of
> what happens would be nice.

The crash is a little hard to reproduce. I have only observed it while
looping a Wi-Fi integration test we have, where it happens maybe 10-20%
of the time. When I am back in the office on Monday I will try to
prepare a detailed answer to your question.

> So I think Andrew's suggestion of also checking for get_scan_id being
> not zero also makes sense.=C2=A0 It would keep things consistent with the
> comment in scan_notify where it says that we do not start the next
> request until GET_SCAN has been done.

Agreed. I'll prepare a v3 patch and send it to you soon.

Kind regards,
Alvin
--===============3756360189824477651==--

