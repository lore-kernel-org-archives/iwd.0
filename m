Received: from mail.pappacoda.it (mail.pappacoda.it [128.116.175.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A157488
	for <iwd@lists.linux.dev>; Thu,  3 Nov 2022 15:48:51 +0000 (UTC)
Received: from [192.168.178.107] (orino.pappacoda.it [128.116.201.23])
	by mail.pappacoda.it (Postfix) with ESMTPSA id 6F72A3D4D1;
	Thu,  3 Nov 2022 16:48:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pappacoda.it;
	s=20211226; t=1667490529;
	bh=MSj6GawQccE3P3XI62gdg6lgWJDLts7+834+0hEd4p0=;
	h=Date:From:Subject:To:Cc:In-Reply-To:References:From;
	b=Qtqi29WnfQdGvYpuD2hF5+KC6bdWDJH7MXb+/niR3+4vNLiszEPMcsvBd0UihrZ4A
	 Umpuw+shadGpIOXOL9i3dvFVS/5jN6jTRKNXfcRysZ2t/V8nbQ8dSkE1JE+c3ZJLxf
	 /VzJ3fKN2gPo3DkX7MXh5eoOo+vFxHP6SDoPPzNADoRwfl+ZiQszy43AJ5nDfj5pxm
	 p6uomvvh/bx5gyHPWliTkH8gGrNRWjbi70RsFm2uLGpeKyemwkEwqZnKDm2xgWUDeg
	 JNWAso3kqUHuJ8AwgqBrOMBDIGa7PChX31AjcLrX1z+piy/Hn6PmnTt3YyV4QINk8w
	 KjkUQm4DrILzQ==
Date: Thu, 03 Nov 2022 16:48:41 +0100
From: Andrea Pappacoda <andrea@pappacoda.it>
Subject: Re: [PATCH 1/2] netconfig: add global MulticastDNS option
To: Rhys Perry <rhysperry111@gmail.com>
Cc: iwd@lists.linux.dev, James Prestwood <prestwoj@gmail.com>
Message-Id: <5X3SKR.2RJQXQUUD6QA@pappacoda.it>
In-Reply-To: <CAGTBY+uDse4b5KzLmVN1Xx5w6bnYAgzT+hO9GPxzavP-8UiHeA@mail.gmail.com>
References: <20221103105639.8289-1-andrea@pappacoda.it>
	<CAGTBY+uDse4b5KzLmVN1Xx5w6bnYAgzT+hO9GPxzavP-8UiHeA@mail.gmail.com>
X-Mailer: geary/43.0
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed

Il giorno gio 3 nov 2022 alle 14:23:57 +00:00:00, Rhys Perry 
<rhysperry111@gmail.com> ha scritto:
> Since we're getting a global setting for mDNS, would it make sense to
> add a global setting for DNS at the same time too?

I'm not sure about this. Setting a default system-wide DNS server is 
already possible by other means (by editing /etc/resolve.conf, 
modifying systemd-resolved options, etc.). Also, overriding the DNS 
server received via DHCP can create issues, and I wouldn't feel 
comfortable in enabling such a setting for all of my networks. Lastly, 
I believe that having a global MulticastDNS option makes sense because 
the network manager is the only entity that can tell sd-resolved to use 
mDNS on a given link.


