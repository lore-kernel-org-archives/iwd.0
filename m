Content-Type: multipart/mixed; boundary="===============6278026322191167508=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2] agent: call back even if agent disconnects
Date: Fri, 09 Apr 2021 11:37:26 -0500
Message-ID: <adf35e5b-e425-e091-c284-7d2a1b7a16a3@gmail.com>
In-Reply-To: <20210409163714.1307122-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6278026322191167508==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 4/9/21 11:37 AM, James Prestwood wrote:
> It was found that if the user cancels/disconnects the agent prior to
> entering credentials, IWD would get stuck and could no longer accept
> any connect calls with the error "Operation already in progress".
> For example exiting iwctl in the Password prompt would cause this:
> =

> iwctl
> $ station wlan0 connect myssid
> $ Password: <Ctrl-C>
> =

> This was due to the agent never calling the network callback in the
> case of an agent disconnect. Network would wait indefinitely for the
> credentials, and disallow any future connect attempts.
> =

> To fix this agent_finalize_pending can be called in agent_disconnect
> with a NULL reply which behaves the same as if there was an
> internal timeout and ultimately allows network to fail the connection
> ---
>   src/agent.c | 3 +++
>   1 file changed, 3 insertions(+)
> =


Applied, thanks.

Regards,
-Denis

--===============6278026322191167508==--

