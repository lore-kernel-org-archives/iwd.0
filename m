Content-Type: multipart/mixed; boundary="===============8082351236353315959=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] crypto: fix copy size causing overruns/crashing
Date: Thu, 03 Oct 2019 11:53:21 -0500
Message-ID: <067fa11c-3de1-e893-02d7-526d2ab2efb5@gmail.com>
In-Reply-To: <20191003113516.GC8802@dtznix>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8082351236353315959==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Will,

On 10/3/19 11:35 AM, Will Dietz wrote:
> num_ad is already accounted for in `sizeof(iov)`
> as iov has size `sizeof(struct iovec) * (num_ad+1)`.
> ---
>   src/crypto.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> =


Can you use git send-email to submit this? When I save this message it =

comes in as multipart with the signature, etc included and seems to =

confuse git am.

Regards,
-Denis
--===============8082351236353315959==--

