Content-Type: multipart/mixed; boundary="===============6171557039836620106=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] network: add L_WARN for known network lookup failure
Date: Fri, 25 Oct 2019 13:19:47 -0500
Message-ID: <a25b9c57-eae2-bf90-273e-ae71a1518720@gmail.com>
In-Reply-To: <20191025165321.19718-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6171557039836620106==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 10/25/19 11:53 AM, James Prestwood wrote:
> When updating the network ranking there was a potential out of bounds
> array access. The condition was if known_network_offset returned a
> negative value, indicating the known network was not found. Since
> network->info is only set for known networks this should not ever
> happen as network->info is checked prior.
> =

> Though this is likely impossible, knownnetworks is complex enough that
> its better to just be paranoid and put an L_WARN_ON to check the
> return.
> ---
>   src/network.c | 2 ++
>   1 file changed, 2 insertions(+)
> =


Applied, thanks.

Regards,
-Denis

--===============6171557039836620106==--

