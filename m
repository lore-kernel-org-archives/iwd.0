Content-Type: multipart/mixed; boundary="===============7491604600536250141=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 5/8] auto-t: hwsim.py: handle Prefix/Enabled in __str__
Date: Wed, 18 Aug 2021 15:09:31 -0700
Message-ID: <20210818220934.295721-5-prestwoj@gmail.com>
In-Reply-To: <20210818220934.295721-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7491604600536250141==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/util/hwsim.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/autotests/util/hwsim.py b/autotests/util/hwsim.py
index 3a83bcd8..52543062 100755
--- a/autotests/util/hwsim.py
+++ b/autotests/util/hwsim.py
@@ -171,7 +171,9 @@ class Rule(HwsimDBusAbstract):
                prefix + '\tFrequency:\t' + str(self.frequency) + '\n' + \
                prefix + '\tApply rssi:\t' + str(self.signal) + '\n' + \
                prefix + '\tApply drop:\t' + str(self.drop) + '\n' + \
-               prefix + '\tPrefix:\t' + str([hex(b) for b in self.prefix])=
 + '\n'
+               prefix + '\tPrefix:\t' + str([hex(b) for b in self.prefix])=
 + '\n' + \
+               prefix + '\tDelay:\t' + str(self.delay) + '\n' + \
+               prefix + '\tEnabled:\t' + str(self.enabled) + '\n'
 =

 class RuleSet(collections.Mapping):
     def __init__(self, hwsim, objects):
-- =

2.31.1

--===============7491604600536250141==--

