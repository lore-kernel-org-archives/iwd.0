Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE272F2A
	for <iwd@lists.linux.dev>; Fri, 13 Jan 2023 15:23:26 +0000 (UTC)
Received: by mail-ot1-f44.google.com with SMTP id f88-20020a9d03e1000000b00684c4041ff1so2708090otf.8
        for <iwd@lists.linux.dev>; Fri, 13 Jan 2023 07:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IjijjCEVwb5SXDnz6QGNAVaX9yRFX6ImmvIkj8dPz1g=;
        b=ZPF5aH+t3DgEeA++J8GIWDM+ZGumbeZ4J92MY+8vUl+B3ZnLxOSB7lkAWOFF0+uxVn
         nMv2Mt57dVHK650LJnehSjuR1sT1vxZ7tD1TtxFvQFtF1tWuA78LtYXyOEpiuKsnx3S6
         GteXLsvXRm82vCfiOh4rOTMLW6UUDQhrqv5uCz772YU0/k2mSWHNZgZAo7QUF685imVU
         N9L16HnhxNWDqcZBumIyj9ngrdMFF+l5MYoVdMWgdq3NxlC/R4QbeJyFD2uIypR+72NM
         8nkhrSyFp8pPM32FmEwfm24zYuRdqTaA/JaG1qn9S7XzrRXJeAunsLdw9ujcHLgGe7bs
         gR+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IjijjCEVwb5SXDnz6QGNAVaX9yRFX6ImmvIkj8dPz1g=;
        b=WJDuUYyfuOu/SRnYa4R9z2epEr1lWiyul6erwjyfOHDU2Z/dwHbhQ+341QCcHWOH+G
         LXaoc3on4VQqY07F7iNGfqNlGdkd+j9xr0qPXOXsFnwCMOVszi2GhqoPc+U77O9uEmCa
         DMz5KxlmLVNPHWNoYzG1QPeucPclvz8ZbOrj8OY4CSxA88EG1Wq48ksco7NR7RTZ0IQv
         /NRAZ57Wnib5bJtTZsBPUbxEaN+Zoc+HiWc9GRJLoXqICB3KHKM4OtmXT/+isVQxey9l
         s9nl94zQyrFt24sFBL8L8lVsK8Bd1fddCupwhJCmglp1kWfP8scEIB9jHr7/3ACNPMlJ
         Ej3g==
X-Gm-Message-State: AFqh2ko0hOp3/R12vwLybJS9amVt5nlbJzHbPhS3GnKvfqTB2IVWAQ5k
	zviv4djVlxOH0yhiFvuZt51d2dORmQM=
X-Google-Smtp-Source: AMrXdXvJ4dKivtRFnxw1DZgzBdXr0qBCj0mVA0i5aFtgY/QA3qRoFz+inRt5DMJYZAN4HNn24Kf8mA==
X-Received: by 2002:a9d:6186:0:b0:661:dfeb:ea33 with SMTP id g6-20020a9d6186000000b00661dfebea33mr13592087otk.24.1673623405340;
        Fri, 13 Jan 2023 07:23:25 -0800 (PST)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id q33-20020a056830442100b00684cbd8dd49sm1674824otv.79.2023.01.13.07.23.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 07:23:24 -0800 (PST)
Message-ID: <7711c2ef-fbdf-782c-718c-cb2eb19ec287@gmail.com>
Date: Fri, 13 Jan 2023 09:16:11 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/4] eapol: detect message 2/4 retransmits
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20230112193212.568476-1-prestwoj@gmail.com>
 <20230112193212.568476-2-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20230112193212.568476-2-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 1/12/23 13:32, James Prestwood wrote:
> If the authenticator has already set an snonce then the packet must
> be a retransmit. Handle this by sending 3/4 again but making sure
> to not reset the frame counter.
> ---
>   src/eapol.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 

Applied, thanks.

Regards,
-Denis

