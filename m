Received: from mta05-relay.cloud.vadesecure.com (mta05-relay.cloud.vadesecure.com [195.154.80.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E280212B62
	for <iwd@lists.linux.dev>; Wed, 10 May 2023 13:46:55 +0000 (UTC)
Received: from mail01.bodet.com (unknown [84.239.65.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mta05-relay.cloud.vadesecure.com (vceu3mtao01p) with ESMTPS id 4QGbk927Kbz7TC9
	for <iwd@lists.linux.dev>; Wed, 10 May 2023 15:40:01 +0200 (CEST)
Received: from BODMAIL01.TREM.BOD (172.18.41.21) by BODMAIL01.TREM.BOD
 (172.18.41.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 10 May
 2023 15:40:00 +0200
Received: from BODMAIL01.TREM.BOD ([::1]) by BODMAIL01.TREM.BOD ([::1]) with
 mapi id 15.01.2507.023; Wed, 10 May 2023 15:40:00 +0200
From: "clement.legoffic@kelio.com" <clement.legoffic@kelio.com>
To: "iwd@lists.linux.dev" <iwd@lists.linux.dev>
Subject: end scan event
Thread-Topic: end scan event
Thread-Index: AdmDROSyzshRAMieTfyPbvBOSCojcA==
Date: Wed, 10 May 2023 13:40:00 +0000
Message-ID: <8cbcd21611474bdaadd76652d756c21b@kelio.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-originating-ip: [172.18.114.25]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-VRC-SPAM-STATUS: 0,15,gggruggvucftvghtrhhoucdtuddrgedvhedrfeegiedggeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuggftvedpqfgfvfenuceurghilhhouhhtmecufedttdenucgogfegtdekqdekleculdduhedmnecujfgurhephffvufhtfffkihgtgfggsehtqhhjtddttddunecuhfhrohhmpedftghlvghmvghnthdrlhgvghhofhhfihgtsehkvghlihhordgtohhmfdcuoegtlhgvmhgvnhhtrdhlvghgohhffhhitgeskhgvlhhiohdrtghomheqnecuggftrfgrthhtvghrnhepgfdvjeeiuefhkeevfffhteegudehfedvfeeufeevvdejfffhhfeiudffteeiiedtnecukfhppeekgedrvdefledrieehrdeljedpudejvddrudekrdduudegrddvheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhmrgigmhhsghhsihiivgepuddtgeekheejiedpihhnvghtpeekgedrvdefledrieehrdeljedphhgvlhhopehmrghilhdtuddrsghouggvthdrtghomhdpmhgrihhlfhhrohhmpegtlhgvmhgvnhhtrdhlvghgohhffhhitgeskhgvlhhiohdrtghomhdpnhgspghrtghpthhtohepuddprhgtphhtthhopehifigusehlihhsthhsrdhlihhnuhigrdguvghv
X-VRC-SPAM-STATE: legit
X-VRC-POLICY-STATUS: t=1,a=1,l=0

Hi,

I am currently writing a DBUS client to IWD in c using glib to do simple ta=
sks such as Scan() or GetOrderedNetworks().
For the scan purpose I wanted to know if IWD does provide an end scan event=
 or signal ?


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
