Content-Type: multipart/mixed; boundary="===============4270522690574132601=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] auto-t: increase wait time for blacklist test
Date: Wed, 08 Jul 2020 18:29:25 -0500
Message-ID: <36b5dc38-fd74-89d9-0df7-41a47a55f253@gmail.com>
In-Reply-To: <20200708174801.14447-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4270522690574132601==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 7/8/20 12:48 PM, James Prestwood wrote:
> This test was not reliably passing. Busy waiting is not really reliable,
> but in this specific case its really the only option as the blacklist
> must expire based on time.
> ---
>   autotests/testBSSBlacklist/connection_test.py | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> =


Both applied, thanks.

Regards,
-Denis

--===============4270522690574132601==--

