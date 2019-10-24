Content-Type: multipart/mixed; boundary="===============9009196320501229331=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/4] client: Don't check for errors on agent requests
Date: Thu, 24 Oct 2019 15:18:47 -0500
Message-ID: <8b1c9bbb-0928-0f4a-bfe2-67942ff2109f@gmail.com>
In-Reply-To: <20191024195356.28206-3-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============9009196320501229331==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tim,

On 10/24/19 2:53 PM, Tim Kourt wrote:
> This assumes that iwd will never send the errors as agent requests,
> therefore, eliminate the unnecessary checks.
> ---
>   client/agent.c | 12 ------------
>   1 file changed, 12 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============9009196320501229331==--

