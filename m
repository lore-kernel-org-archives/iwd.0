Received: from mta03-relay.cloud.vadesecure.com (mta03-relay.cloud.vadesecure.com [52.47.203.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD70D33E3
	for <iwd@lists.linux.dev>; Thu, 23 Mar 2023 09:58:18 +0000 (UTC)
Received: from mail01.bodet.com (unknown [84.239.65.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mta03-relay.cloud.vadesecure.com (vceu2mtao01p) with ESMTPS id 4Pj0xH265Xz1nkl
	for <iwd@lists.linux.dev>; Thu, 23 Mar 2023 10:52:03 +0100 (CET)
Received: from BODMAIL01.TREM.BOD (172.18.41.21) by BODMAIL01.TREM.BOD
 (172.18.41.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 23 Mar
 2023 10:52:02 +0100
Received: from BODMAIL01.TREM.BOD ([::1]) by BODMAIL01.TREM.BOD ([::1]) with
 mapi id 15.01.2507.021; Thu, 23 Mar 2023 10:52:02 +0100
From: "clement.legoffic@kelio.com" <clement.legoffic@kelio.com>
To: "iwd@lists.linux.dev" <iwd@lists.linux.dev>
Subject: No Agent registered when calling Connect method
Thread-Topic: No Agent registered when calling Connect method
Thread-Index: Adldacp1InLt2OkRTGaUs9Qdi9TISA==
Date: Thu, 23 Mar 2023 09:52:02 +0000
Message-ID: <a1840fea7c5e4233ac102e450e7ef873@kelio.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-originating-ip: [172.18.114.58]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-VRC-SPAM-STATUS: 0,15,gggruggvucftvghtrhhoucdtuddrgedvhedrvdeggedgtdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuggftvedpqfgfvfenuceurghilhhouhhtmecufedttdenucgogfegtdekqdekleculdduhedmnecujfgurhephffvufhtfffkihgtgfggsehtqhhjtddttddvnecuhfhrohhmpedftghlvghmvghnthdrlhgvghhofhhfihgtsehkvghlihhordgtohhmfdcuoegtlhgvmhgvnhhtrdhlvghgohhffhhitgeskhgvlhhiohdrtghomheqnecuggftrfgrthhtvghrnhepgeeiffegjefhfeeufeelvdfftdevtddtuefgleetiedvieeftdehledugeeiuedunecuffhomhgrihhnpehifigurdhnvghtfihorhhknecukfhppeekgedrvdefledrieehrdeljedpudejvddrudekrdduudegrdehkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhmrgigmhhsghhsihiivgepuddtgeekheejiedpihhnvghtpeekgedrvdefledrieehrdeljedphhgvlhhopehmrghilhdtuddrsghouggvthdrtghomhdpmhgrihhlfhhrohhmpegtlhgvmhgvnhhtrdhlvghgohhffhhitgeskhgvlhhiohdrtghomhdpnhgspghrtghpthhtohepuddprhgtphhtthhopehifigusehlihhsthhsrdhlihhnuhigrdguvghv
X-VRC-SPAM-STATE: legit
X-VRC-POLICY-STATUS: t=1,a=1,l=0

Hello,

I want to connect to a psk network using iwd D-BUS interface.
I am using IWD version 1.25 with sytemd.
To call D-BUS method I use busctl.
My actions are :

Scan for networks :
busctl call net.connman.iwd /net/connman/iwd/0/6 net.connman.iwd.Station Sc=
an

Register an agent :
busctl call net.connman.iwd /net/connman/iwd net.connman.iwd.AgentManager R=
egisterAgent o /test/agent/1234

Call Connect method my object Interface
busctl call net.connman.iwd /net/connman/iwd/0/6/Xxxxx net.connman.iwd.Netw=
ork Connect

But I get the error :
Call failed: No Agent registered

So I restart iwd deamon with debug output and try to connect to my network =
using iwctl
iwctl station wlan0 connect SSID

IWD debug output with the iwctl command is :
src/agent.c:agent_register() agent register called
src/agent.c:agent_register() agent :1.71 path /agent/471
src/network.c:network_connect()
src/network.c:network_connect_psk() ask_passphrase: true
src/agent.c:agent_request_passphrase() agent 0xb9ca8 owner :1.71 path /agen=
t/471
src/agent.c:agent_send_next_request() send request to :1.71 /agent/471
src/agent.c:agent_receive_reply() agent 0xb9ca8 request id 22
src/network.c:passphrase_callback() result 0

And I get connected

Whereas the debug output using the D-BUS Call is :
src/agent.c:agent_register() agent register called
src/agent.c:agent_register() agent :1.78 path /test/agent/1234
src/agent.c:agent_disconnect() agent :1.78 disconnected
src/agent.c:agent_free() agent free 0xbb1a0
src/network.c:network_connect()
src/network.c:network_connect_psk() ask_passphrase: true

And I'm not able to connect to my network/

We can observe that the agent disconnect before the network_connect(), Is i=
t a normal behaviour ?

So my question is how to use the RegisterAgent method in order to connect t=
o a psk Network with DBUS ?

Thanks in advance


Ce message et toutes les pieces jointes (ci-apres le "message") sont etabli=
s a l'intention exclusive de ses destinataires.
Si vous recevez ce message par erreur, merci de le detruire et d'en avertir=
 immediatement l'expediteur par e-mail.
Toute utilisation de ce message non conforme a sa destination, toute diffus=
ion ou toute publication, totale ou partielle, est interdite, sauf autorisa=
tion expresse. Les communications sur Internet n'etant pas securisees, l'ex=
pediteur informe qu'il ne peut accepter aucune responsabilite quant au cont=
enu de ce message.
This mail message and attachments (the "message") are solely intended for t=
he addresses. It is confidential in nature.
If you receive this message in error, please delete it and immediately noti=
fy the sender by e-mail.
Any use other than its intended purpose, dissemination or disclosure, eithe=
r whole or partial, is prohibited except if formal approval is granted. As =
communication on the Internet is not secure, the sender does not accept res=
ponsibility for the content of this message.
