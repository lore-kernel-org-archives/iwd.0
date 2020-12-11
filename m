Content-Type: multipart/mixed; boundary="===============0696254476319728770=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] client: ignore control sequence length in prompt
Date: Fri, 11 Dec 2020 21:13:23 +0000
Message-ID: <e85ca663-fd54-72da-de69-12f46a33c989@gmail.com>
In-Reply-To: <20201211063222.67764-1-rpigott@berkeley.edu>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0696254476319728770==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Ronan,

On 12/11/20 12:32 AM, Ronan Pigott wrote:
> From: Ronan Pigott <rpigott@berkeley.edu>
> =

> Readline uses the characters \001 and \002 to mark the start and end
> of zero-length character sequnces in the prompt before prompt
> expansion. Without these characters the input point can become offset
> from the visual end of the prompt when performing some actions.
> ---
> =

> iwctl gets messed up if you press up and down once to recall and
> then dismiss the last history line. This fixes that.

Interesting.  I have never observed this behavior and I do this often.

> =

>   client/display.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> =


Applied, thanks.

Regards,
-Denis
--===============0696254476319728770==--

