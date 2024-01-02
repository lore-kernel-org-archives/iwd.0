Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F41FF9E6
	for <iwd@lists.linux.dev>; Tue,  2 Jan 2024 13:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bii5QPoL"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6d9af1f12e8so2080015b3a.1
        for <iwd@lists.linux.dev>; Tue, 02 Jan 2024 05:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704201513; x=1704806313; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2oAzhbhNMDI9KuvoinAubFGfxo6lu6/IndkMez7WmTw=;
        b=bii5QPoLbU68UWQ+4PSLAbCnoQY0o2jUaNRgLcUm9pVzWtrRpCmui/DY6zuhTxGzs1
         Z3epTK1QUWioXGn0y82WmRNqdQWAme8/nZEoUc6xlqEFkJdNG4Bu59PrxGP68FT161fU
         H02oHYmobToeqXixVPZUDNjTOSqADlCBW6ww68WgPTwvmfZmOkWTZcMqjSiyrjdxb6nL
         GagaXmq6UEsZldhY2R7HyyTZprRMV9fbhzocDg4J4zbLwHI8z5TeUiwX8hOE/Ztz6x0F
         L/ZxvKn2YbDDh/ZK3qdBrC9pusfjMGUopz89V4oerLRE/bcDBXB/oZgqfMexvXmqbn3m
         jwUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704201513; x=1704806313;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2oAzhbhNMDI9KuvoinAubFGfxo6lu6/IndkMez7WmTw=;
        b=RVLyMvvXr/i1lUdmSZbMHJIcTZiRQnFXf6+1R6PrvU7Bw6YY3dc4S7JEpDF0tZTInP
         p8ewR3RBqmG21DeX4v7BgoESIPrcJ5b61LBvdTgamcdqVfrw73WDtC1vzpjDom/1Oy7s
         wNBeZq7iwGNjzzX0gMPrnHsgKP3z++PpZ/HUxY0C3E+bdU8RKw1y7vcM0pyaOh1gw18s
         z8eGuxHJJYxV7nUJUc8HPrhquBOUsb9pRs1u6PU6UjXEkfQ3t3At838TTlECT857GZho
         rXi9d/vwIluCEIAfFRYKBg7UlPSsxUv6zWwNbW1n5mNOwMXTek9sIvLIVfLqYXIB5jjN
         FK/w==
X-Gm-Message-State: AOJu0YzrU0NwvW/HakD4RZioJdiQyGbz979xuaQOyydz5rc/2kWLtmbs
	T7I+WzKKWUUEQ9+xI8I/KVzBhgwchxw=
X-Google-Smtp-Source: AGHT+IHAmdMmdA1pnYLlEnogdbqLOGT1mybLD45NtKnU9+TnZJ6NQ8UVgF0dN6G+ml7RnF3IX6KTgQ==
X-Received: by 2002:a05:6a20:5522:b0:190:53c1:fed1 with SMTP id ko34-20020a056a20552200b0019053c1fed1mr6474446pzb.40.1704201511414;
        Tue, 02 Jan 2024 05:18:31 -0800 (PST)
Received: from [192.168.254.82] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id fb35-20020a056a002da300b006d9bff075cfsm14046716pfb.33.2024.01.02.05.18.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jan 2024 05:18:31 -0800 (PST)
Message-ID: <66e1ad50-ddeb-49b5-af28-86250f32ea9a@gmail.com>
Date: Tue, 2 Jan 2024 05:18:30 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] knownnetworks: add
 known_network_add_connected_frequency
Content-Language: en-US
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20231220131200.267489-1-prestwoj@gmail.com>
 <20231220131200.267489-3-prestwoj@gmail.com>
 <34a92d63-b37f-4f37-a29b-9e632bb94d5a@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <34a92d63-b37f-4f37-a29b-9e632bb94d5a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,
>
> Overall I'm getting the feeling that the linked-list is the wrong data 
> structure for all this.  If the intent is to maintain a bounded 
> shortlist of frequencies to scan for a given network, then that's what 
> we should do instead.

Yeah I agree, this is a bit complicated. I think a much simpler approach 
would be to limit the known frequency list to some maximum size (e.g. 5) 
and store frequencies based on the BSS rank rather than seen/connected.

Thanks,

James

>
> Regards,
> -Denis
