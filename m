Content-Type: multipart/mixed; boundary="===============6143129570945564560=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] client: Cancel agent prompt with CTRL+D
Date: Mon, 28 Oct 2019 14:57:54 -0500
Message-ID: <432d61fa-8c81-7fb6-d345-5820038c9f2c@gmail.com>
In-Reply-To: <20191028172933.13643-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6143129570945564560==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tim,

On 10/28/19 12:29 PM, Tim Kourt wrote:
> Previously, CTRL+D used to cause termination of the client. Now, the
> command will cancel the agent=E2=80=99s prompts in agent mod. In regular =
mode
> the behavior is unchanged.
> ---
>   client/agent.c   | 28 +++++++++++++++++++---------
>   client/display.c |  8 ++++----
>   2 files changed, 23 insertions(+), 13 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============6143129570945564560==--

