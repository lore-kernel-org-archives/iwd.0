Content-Type: multipart/mixed; boundary="===============4427717426256503847=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Interface not detected sometimes
Date: Thu, 06 Feb 2020 10:27:41 -0600
Message-ID: <a3e8180c-51f5-baf9-a279-2eff703d200b@gmail.com>
In-Reply-To: <20200205192836.2820.73709@ml01.vlan13.01.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4427717426256503847==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Hector,

On 2/5/20 1:28 PM, hector(a)ikatu.com wrote:
> Denis,
> =

> I tried your patch and it seems like the problem is solved. I tested that=
 the initialization works even when I get the "No default interface for wip=
hy 0", so the retry you added after that fixed it:
> =


Excellent!  Thanks for testing.

> =

> Thank you so much!

No worries.  I've pushed this patch out upstream.

Regards,
-Denis
--===============4427717426256503847==--

