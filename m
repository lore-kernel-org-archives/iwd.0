Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1B16FA1
	for <iwd@lists.linux.dev>; Fri, 24 Mar 2023 15:13:50 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id w4so2056107plg.9
        for <iwd@lists.linux.dev>; Fri, 24 Mar 2023 08:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679670830;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WzMFwoFMV0XLsgbyX82n+CsQVxyIetfg8QircSyVpT0=;
        b=fgnrqx/bEMSAZ+K2G8QE8IdpkMdgjjHZYhhozKoNqsn103Ys7BAjLwp1phnSksLHOV
         r67xbeLFu+ShhpRuS0BykpLsCgwMJtZfNhmgQdsHfzRvDcm5/lTLsT8MJVRhcteouPkx
         4AVdL9QacG3MTVmF2mR/klMK2YdaB/47fQGimfG6qVQB8cKYKBkO13wyw99IJVXd5f3L
         epcNUemuVsh3LFCCeJ4WmEAYx59QIQ8amDG1qLsFgWKmMXR3PRI4z4R5hhlmlELstSN0
         nqgp+XGWjrZat9AOdeukux3blhRGQCyc/7Wr8BJoYQRsP/EODeXcEWSCrghrS4VlXItt
         s8og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679670830;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WzMFwoFMV0XLsgbyX82n+CsQVxyIetfg8QircSyVpT0=;
        b=5/IlgmE60qkuBZBMC8uXRxrGbPVbrNdv7JJk4GshZmar5oAGXFVwQnBZJUhYjatmIm
         jIs7aQc6eMVKgYJZ0iOpvIN16b7vXZWtneu4za6Kc/fGRkX0qWdkYGis/2ZqImL0OkJ1
         x/IVhsvAzoRiWlFj8DE+CAgI2XrrSsL2iPzwCFoI/Ih+4wV+cDR8BIkkkqeDxkFRP3gS
         uIylDX45UeDIsJSbqXJ7cMUF9/SwVN8ltoeDs/8aQ67J+fYmqAegyDgsqSEHdeRQRShC
         L2rjSd+LKfE7d9ITZTmL+BnPYSeYi/7QWlokipS8Havoz0gdNpz7y1GC6dWzZ6IhkU12
         hIgQ==
X-Gm-Message-State: AAQBX9cZ8FAXaj5RNbxO5hhs3TE1qLLlf2twk4mSZJhPTacWuG7udJIi
	xLJ+SJkh+nHmqZho7A1ryvo=
X-Google-Smtp-Source: AKy350YnxmsFknOsOS0MXyrpfrvgxZVSueMTdbOWQgEat6LQd2aByoo4QqrdefW9Jnw3aE11+HjL+g==
X-Received: by 2002:a17:90b:33c7:b0:23d:4ffc:43e with SMTP id lk7-20020a17090b33c700b0023d4ffc043emr2923062pjb.38.1679670829851;
        Fri, 24 Mar 2023 08:13:49 -0700 (PDT)
Received: from [192.168.254.13] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id f62-20020a17090a704400b00234afca2498sm21922pjk.28.2023.03.24.08.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 08:13:49 -0700 (PDT)
Message-ID: <14aa2e7b806bed3b7f30889e5502ef90434ccfc4.camel@gmail.com>
Subject: Re: No Agent registered when calling Connect method
From: James Prestwood <prestwoj@gmail.com>
To: "clement.legoffic@kelio.com" <clement.legoffic@kelio.com>, 
	"iwd@lists.linux.dev"
	 <iwd@lists.linux.dev>
Date: Fri, 24 Mar 2023 08:13:49 -0700
In-Reply-To: <a187bab1a26a4adba9be33160de6def1@kelio.com>
References: <a1840fea7c5e4233ac102e450e7ef873@kelio.com>
	 <77b8a647caac0e132fdbdf7c8896baf0e37f65ba.camel@gmail.com>
	 <a187bab1a26a4adba9be33160de6def1@kelio.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 2023-03-24 at 09:42 +0000, clement.legoffic@kelio.com wrote:
> Hi,
> 
> Thank you for your answer !
> 
> > Hi,
> > 
> > On Thu, 2023-03-23 at 09:52 +0000,
> > clement.legoffic@kelio.com wrote:
> > > Hello,
> > > 
> > > I want to connect to a psk network using iwd D-BUS interface.
> > > I am using IWD version 1.25 with sytemd.
> > > To call D-BUS method I use busctl.
> > 
> > I think using busctl for an agent is likely the problem. An agent
> > for IWD is a
> > DBus service, so it must be running and able to accept incoming
> > requests
> > for passphrase/usernames etc.
> 
> Ok I understand.
> 
> > 
> > > My actions are :
> > > 
> > > Scan for networks :
> > > busctl call net.connman.iwd /net/connman/iwd/0/6
> > > net.connman.iwd.Station Scan
> > > 
> > > Register an agent :
> > > busctl call net.connman.iwd /net/connman/iwd
> > > net.connman.iwd.AgentManager RegisterAgent o /test/agent/1234
> > > 
> > > Call Connect method my object Interface busctl call
> > > net.connman.iwd
> > > /net/connman/iwd/0/6/Xxxxx net.connman.iwd.Network Connect
> > > 
> > > But I get the error :
> > > Call failed: No Agent registered
> > > 
> > > So I restart iwd deamon with debug output and try to connect to
> > > my
> > > network using iwctl iwctl station wlan0 connect SSID
> > > 
> > > IWD debug output with the iwctl command is :
> > > src/agent.c:agent_register() agent register called
> > > src/agent.c:agent_register() agent :1.71 path /agent/471
> > > src/network.c:network_connect()
> > > src/network.c:network_connect_psk() ask_passphrase: true
> > > src/agent.c:agent_request_passphrase() agent 0xb9ca8 owner :1.71
> > > path
> > > /agent/471
> > > src/agent.c:agent_send_next_request() send request to :1.71
> > > /agent/471
> > > src/agent.c:agent_receive_reply() agent 0xb9ca8 request id 22
> > > src/network.c:passphrase_callback() result 0
> > > 
> > > And I get connected
> > > 
> > > Whereas the debug output using the D-BUS Call is :
> > > src/agent.c:agent_register() agent register called
> > > src/agent.c:agent_register() agent :1.78 path /test/agent/1234
> > > src/agent.c:agent_disconnect() agent :1.78 disconnected
> > > src/agent.c:agent_free() agent free 0xbb1a0
> > > src/network.c:network_connect()
> > > src/network.c:network_connect_psk() ask_passphrase: true
> > > 
> > > And I'm not able to connect to my network/
> > > 
> > > We can observe that the agent disconnect before the
> > > network_connect(),
> > > Is it a normal behaviour ?
> > > 
> > > So my question is how to use the RegisterAgent method in order to
> > > connect to a psk Network with DBUS ?
> > 
> > IWD has a simple agent service written in Python for reference:
> > https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/test/simple
> > -
> > agent
> 
> I have read this code but maybe not understand it.
> Does I need to create my own Agent ? Wich respect the doc agent-api
> here : 
> https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/doc/agent-api.txt
> 
> Why can't I use the IWD agent which iwctl use ?

You can use iwctl as the agent, and you already did this to connect
above. What's the problem doing it this way?

Thanks,
Jame

> 
> Thanks
> 
> > 
> > Thanks,
> > James
> > 
> > > 
> > > Thanks in advance
> > > 
> > > 


