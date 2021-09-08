Content-Type: multipart/mixed; boundary="===============1408095594925428563=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/9] hwsim: add MatchTimes property
Date: Tue, 07 Sep 2021 20:03:32 -0500
Message-ID: <293d1813-5958-670b-a0d4-3154e0547ee9@gmail.com>
In-Reply-To: <20210907211450.27270-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1408095594925428563==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 9/7/21 4:14 PM, James Prestwood wrote:
> This integer property can be set to only match a rule a number of
> times rather than all packets. This is useful for testing behavior
> of a single dropped frame or ack. Once the rule has been matched
> 'MatchTimes' the rules will no longer be applied (unless set again
> to some integer greater than zero).
> ---
>   tools/hwsim.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 42 insertions(+)
> =


Patches 1-6 applied, thanks.

Regards,
-Denis

--===============1408095594925428563==--

