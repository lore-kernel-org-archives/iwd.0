Content-Type: multipart/mixed; boundary="===============1848631545130337933=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2] agent: call back even if agent disconnects
Date: Fri, 09 Apr 2021 09:37:14 -0700
Message-ID: <20210409163714.1307122-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1848631545130337933==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It was found that if the user cancels/disconnects the agent prior to
entering credentials, IWD would get stuck and could no longer accept
any connect calls with the error "Operation already in progress".
For example exiting iwctl in the Password prompt would cause this:

iwctl
$ station wlan0 connect myssid
$ Password: <Ctrl-C>

This was due to the agent never calling the network callback in the
case of an agent disconnect. Network would wait indefinitely for the
credentials, and disallow any future connect attempts.

To fix this agent_finalize_pending can be called in agent_disconnect
with a NULL reply which behaves the same as if there was an
internal timeout and ultimately allows network to fail the connection
---
 src/agent.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/agent.c b/src/agent.c
index 101eaffd..5e40e1a7 100644
--- a/src/agent.c
+++ b/src/agent.c
@@ -525,6 +525,9 @@ static void agent_disconnect(struct l_dbus *dbus, void =
*user_data)
 =

 	l_debug("agent %s disconnected", agent->owner);
 =

+	if (agent->pending_id)
+		agent_finalize_pending(agent, NULL);
+
 	l_queue_remove(agents, agent);
 =

 	l_idle_oneshot(agent_free, agent, NULL);
-- =

2.26.2

--===============1848631545130337933==--

