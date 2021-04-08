Content-Type: multipart/mixed; boundary="===============2070655468482862185=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [RFC 0/1] client: double password prompt
Date: Thu, 08 Apr 2021 11:02:41 -0700
Message-ID: <20210408180242.1200268-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2070655468482862185==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I am sending this as an RFC as readline magic is not something I am
at all familiar with. The patch seems to fix the issue, but its not
exactly clear to me why. I would like to get eyes on this to ensure
I'm not breaking something unrelated.

The documentation for rl_redisplay() says:

"Change what's displayed on the screen to reflect the current contents
of rl_line_buffer."

My guess is that rl_line_buffer already contains the "Password:" prompt,
and inside display_agent_prompt we call rl_redisplay, then set then
rl_set_prompt which causes the duplicate. Removing rl_redisplay completely
causes problems with single prompt scenarios like PSK networks so the
only way to avoid the call in this multi prompt situation is to add a flag
and let the caller decide.

James Prestwood (1):
  client: fix double password prompt

 client/agent.c   | 10 +++++-----
 client/display.c |  6 ++++--
 client/display.h |  2 +-
 3 files changed, 10 insertions(+), 8 deletions(-)

-- =

2.26.2

--===============2070655468482862185==--

