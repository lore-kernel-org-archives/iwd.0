Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFD8D2FB
	for <iwd@lists.linux.dev>; Thu, 23 Mar 2023 23:02:35 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id j13so18915pjd.1
        for <iwd@lists.linux.dev>; Thu, 23 Mar 2023 16:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679612555;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c7M65MdnqI9RxAgxMC1Jmvoyu4OYgRHxB5FzZtHLuvs=;
        b=fSdcOWBhqOK88yHgxxoShKo1+UI2FEZPtd9rEAs9XTe/ZxTDiP2tgKxCXm7pWdd6oO
         tNXntHZSHQa0UpkgfZ+nofoYVE6WfQPLPA77VuJUQSsRFj/bGkSSgDCktFMjJBPkHfK6
         3OU+DMdP+migZnocDYN2WKzRTgJAoauQbDGMIRjcC8rTO++Zbeq9/GOfz03hdv75C+kv
         w8iz9cte0SWQlpC5JhbEtKC9FpEa2BVUDJfbqDEMTsc8Du9hfVrAfAQMB8WeV0xX2OwB
         u4xLOI3ug1JWKJrJoqnGWmHdZfJCcYAed2ACQdlS09Gme6j9wgDxlNJrpZJFUX4vxmO/
         wW+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679612555;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c7M65MdnqI9RxAgxMC1Jmvoyu4OYgRHxB5FzZtHLuvs=;
        b=F5fCsA7hRsLZoP1kID3SHaFTc5ag/GwHdpyXGGTiXHOS8ZZVd3KdmuH+TZr0AvOZsl
         T5xPYih2ZWTaflbfmOFE6Yj9F3af43dMboBXq39Kzh91eZWoWrI9MZtW0cnDiu7n/A7I
         1VenD4ApUPcynUhV9aH9eh5s0kpP9YzXP1qXw7JsCVTHOoEafH4zt60knOj3bwlUTXt3
         VVhdLMITmBox5Vw5fLe3/CTDXBA6TShMSzB9gHdPYSsY/EIg2FMqJN4cWo1SXOmFl8eq
         EQWFN4jIT8ngTcS972MBeC1Cm0rzyjaO+Ilo7Maz2b/EMlVhagcnA8wfAiJWqdZZ3Cst
         KxDQ==
X-Gm-Message-State: AAQBX9f8hVoypXWnD5BZWHlGG8JEVqjzwFwoglNMhALZOT7rVAVCFcwL
	RTfAOtR7NTaOBT4rQJ5swaM7k1vgN7g=
X-Google-Smtp-Source: AKy350aPOGc3zDKNqg2OcNX+zvIr3t96sQaOeTfuuy60mOwOJJSbkVM9Cq6GipY7d3iQEr7YghCqPg==
X-Received: by 2002:a17:903:2282:b0:19e:bfec:7928 with SMTP id b2-20020a170903228200b0019ebfec7928mr609969plh.24.1679612554663;
        Thu, 23 Mar 2023 16:02:34 -0700 (PDT)
Received: from [192.168.254.13] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id c20-20020a170902b69400b001a1faed8707sm2379000pls.63.2023.03.23.16.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 16:02:34 -0700 (PDT)
Message-ID: <77b8a647caac0e132fdbdf7c8896baf0e37f65ba.camel@gmail.com>
Subject: Re: No Agent registered when calling Connect method
From: James Prestwood <prestwoj@gmail.com>
To: "clement.legoffic@kelio.com" <clement.legoffic@kelio.com>, 
	"iwd@lists.linux.dev"
	 <iwd@lists.linux.dev>
Date: Thu, 23 Mar 2023 16:02:33 -0700
In-Reply-To: <a1840fea7c5e4233ac102e450e7ef873@kelio.com>
References: <a1840fea7c5e4233ac102e450e7ef873@kelio.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Hi,

On Thu, 2023-03-23 at 09:52 +0000, clement.legoffic@kelio.com wrote:
> Hello,
> 
> I want to connect to a psk network using iwd D-BUS interface.
> I am using IWD version 1.25 with sytemd.
> To call D-BUS method I use busctl.

I think using busctl for an agent is likely the problem. An agent for
IWD is a DBus service, so it must be running and able to accept
incoming requests for passphrase/usernames etc.

> My actions are :
> 
> Scan for networks :
> busctl call net.connman.iwd /net/connman/iwd/0/6
> net.connman.iwd.Station Scan
> 
> Register an agent :
> busctl call net.connman.iwd /net/connman/iwd
> net.connman.iwd.AgentManager RegisterAgent o /test/agent/1234
> 
> Call Connect method my object Interface
> busctl call net.connman.iwd /net/connman/iwd/0/6/Xxxxx
> net.connman.iwd.Network Connect
> 
> But I get the error :
> Call failed: No Agent registered
> 
> So I restart iwd deamon with debug output and try to connect to my
> network using iwctl
> iwctl station wlan0 connect SSID
> 
> IWD debug output with the iwctl command is :
> src/agent.c:agent_register() agent register called
> src/agent.c:agent_register() agent :1.71 path /agent/471
> src/network.c:network_connect()
> src/network.c:network_connect_psk() ask_passphrase: true
> src/agent.c:agent_request_passphrase() agent 0xb9ca8 owner :1.71 path
> /agent/471
> src/agent.c:agent_send_next_request() send request to :1.71 /agent/471
> src/agent.c:agent_receive_reply() agent 0xb9ca8 request id 22
> src/network.c:passphrase_callback() result 0
> 
> And I get connected
> 
> Whereas the debug output using the D-BUS Call is :
> src/agent.c:agent_register() agent register called
> src/agent.c:agent_register() agent :1.78 path /test/agent/1234
> src/agent.c:agent_disconnect() agent :1.78 disconnected
> src/agent.c:agent_free() agent free 0xbb1a0
> src/network.c:network_connect()
> src/network.c:network_connect_psk() ask_passphrase: true
> 
> And I'm not able to connect to my network/
> 
> We can observe that the agent disconnect before the network_connect(),
> Is it a normal behaviour ?
> 
> So my question is how to use the RegisterAgent method in order to
> connect to a psk Network with DBUS ?

IWD has a simple agent service written in Python for reference:
https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/test/simple-agent

Thanks,
James

> 
> Thanks in advance
> 
> 
> Ce message et toutes les pieces jointes (ci-apres le "message") sont
> etablis a l'intention exclusive de ses destinataires.
> Si vous recevez ce message par erreur, merci de le detruire et d'en
> avertir immediatement l'expediteur par e-mail.
> Toute utilisation de ce message non conforme a sa destination, toute
> diffusion ou toute publication, totale ou partielle, est interdite,
> sauf autorisation expresse. Les communications sur Internet n'etant pas
> securisees, l'expediteur informe qu'il ne peut accepter aucune
> responsabilite quant au contenu de ce message.
> This mail message and attachments (the "message") are solely intended
> for the addresses. It is confidential in nature.
> If you receive this message in error, please delete it and immediately
> notify the sender by e-mail.
> Any use other than its intended purpose, dissemination or disclosure,
> either whole or partial, is prohibited except if formal approval is
> granted. As communication on the Internet is not secure, the sender
> does not accept responsibility for the content of this message.
> 


