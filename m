Received: from mta03-relay.cloud.vadesecure.com (mta03-relay.cloud.vadesecure.com [52.47.203.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F3BA93A
	for <iwd@lists.linux.dev>; Thu,  8 Jun 2023 14:04:35 +0000 (UTC)
Received: from mail01.bodet.com (unknown [84.239.65.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mta03-relay.cloud.vadesecure.com (vceu2mtao01p) with ESMTPS id 4QcQlt3JWDz1rnW
	for <iwd@lists.linux.dev>; Thu,  8 Jun 2023 15:58:18 +0200 (CEST)
Received: from BODMAIL01.TREM.BOD (172.18.41.21) by BODMAIL02.TREM.BOD
 (172.18.41.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 8 Jun
 2023 15:58:17 +0200
Received: from BODMAIL01.TREM.BOD ([::1]) by BODMAIL01.TREM.BOD ([::1]) with
 mapi id 15.01.2507.023; Thu, 8 Jun 2023 15:58:18 +0200
From: "clement.legoffic@kelio.com" <clement.legoffic@kelio.com>
To: "iwd@lists.linux.dev" <iwd@lists.linux.dev>
Subject: IWD Not Starting anymore
Thread-Topic: IWD Not Starting anymore
Thread-Index: AdmaEULNoZi1MHxtRuy3GNjL6IbSmA==
Date: Thu, 8 Jun 2023 13:58:17 +0000
Message-ID: <032bbeb106b34730939e1e605425af5b@kelio.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-originating-ip: [172.18.114.30]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-VRC-SPAM-STATUS: 0,15,gggruggvucftvghtrhhoucdtuddrgedvhedrgedtiedgjedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuggftvedpqfgfvfenuceurghilhhouhhtmecufedttdenucgogfegtdekqdekleculdduhedmnecujfgurhephffvufhtfffkihgtgfggsehtqhhjtddttddunecuhfhrohhmpedftghlvghmvghnthdrlhgvghhofhhfihgtsehkvghlihhordgtohhmfdcuoegtlhgvmhgvnhhtrdhlvghgohhffhhitgeskhgvlhhiohdrtghomheqnecuggftrfgrthhtvghrnhepgfdvjeeiuefhkeevfffhteegudehfedvfeeufeevvdejfffhhfeiudffteeiiedtnecukfhppeekgedrvdefledrieehrdeljedpudejvddrudekrdduudegrdeftdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhmrgigmhhsghhsihiivgepuddtgeekheejiedpihhnvghtpeekgedrvdefledrieehrdeljedphhgvlhhopehmrghilhdtuddrsghouggvthdrtghomhdpmhgrihhlfhhrohhmpegtlhgvmhgvnhhtrdhlvghgohhffhhitgeskhgvlhhiohdrtghomhdpnhgspghrtghpthhtohepuddprhgtphhtthhopehifigusehlihhsthhsrdhlihhnuhigrdguvghv
X-VRC-SPAM-STATE: legit
X-VRC-POLICY-STATUS: t=1,a=1,l=0

Hello,

I am using iwd on an embedded target for simple task for a while: connectio=
n, disconnection, scan.
Version 1.25
I don't use systemd.
For a while, it has been working well with PSK and EAP-TLS.
But now, I can't even start iwd. Here is the debug output :

root@target ~> /usr/libexec/iwd -d
Wireless daemon version 1.25
src/main.c:main() Using configuration directory /etc/iwd
src/storage.c:storage_create_dirs() Using state directory /var/lib/iwd
src/main.c:nl80211_appeared() Found nl80211 interface
src/module.c:iwd_modules_init()
station: Network configuration is disabled.
src/wsc.c:wsc_init()
Module hotspot failed to start: -2
src/module.c:iwd_modules_exit()
src/wsc.c:wsc_exit()
D-Bus disconnected, quitting...

I don't understand its new behaviour.
The /etc/iwd/main.conf is empty.
Am I doing it wrong ?
Do you have any lead ?

Thanks in advance,

Cl=E9ment


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
