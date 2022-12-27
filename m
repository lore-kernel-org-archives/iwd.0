Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063F13D74
	for <iwd@lists.linux.dev>; Tue, 27 Dec 2022 17:46:20 +0000 (UTC)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-15027746720so1111659fac.13
        for <iwd@lists.linux.dev>; Tue, 27 Dec 2022 09:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EnRIwjY5g8zmfkQt18FdCfpochYU7TxObu2yuNPuWlQ=;
        b=oi++WCDUQW8+XvEBynFmYfeJAVoU+h6hqoS5XQd1VDxIK9z1MPISyxSOcbDvLTy58S
         Hpxa3cU4GXjVTqo+Dkqr/2MivfTwkNLf4vXg+VtGjCyHgB0Bo7SV3hE3ldPR7H3A8saG
         shuY9GlsG3CzaONGhzTMZ//hfx45ja9uCMI4HH51CfkxMOMRJnv67ikRdyChE/9t4YPU
         Us62lzPXeg1kEAtrfxuCEqazzfJqJMQXM7Nko8eOnR7PGhLLhyrJay41p5BW8Z+X6asR
         V/ssXQndiRaDTxetnu07hUSsuGgnfXteHqQjJeTDSvmiTA2C39hkOxPO1ysP6+05mWp+
         RWdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EnRIwjY5g8zmfkQt18FdCfpochYU7TxObu2yuNPuWlQ=;
        b=t3WB2N39DMmG95PdLwGQdB6h0KXEiDOzlMHxftrEafdA/tGLVpg2AwG/RmMeLl9CzU
         hAelOg/Tn23boctwP8rBPL2BvLwcJ0fqK2BPVBcaHJ/WLu/aJL4AXG8J51sfaYkUhQHR
         cG2gn09b79LI3ItBCLpv+lZ4SgXXkabC+TpKVfi372SyVJ6HCvKJBRNZ6+sgS772rm3h
         PQ9rcy77rIy3/TPvHHJKb1qGyUiVYV2a60AdpofVtFiXkekVFXbkMqHwRUhGK6S9lLVW
         MQzWqErw4hP7IP+cvrePq47n/rwfhT/ufwL0mViIrBSqAL8dg/LA4DdaT69xbJXd/9XN
         E5/g==
X-Gm-Message-State: AFqh2koS8tTTJqAMeQtu2WalZK12cz9HPYmttRXBRaaZ2HbFDpl3OlUr
	f2ZAKhoENY0rgw8RxS4+TLsrCW05ozE=
X-Google-Smtp-Source: AMrXdXsu7pQ+T1xko2kcj4Gptnx3ayBDBxUd48QyyKA4TCApbSjayfgD2KTHQR59YbpEprOkhgPrCg==
X-Received: by 2002:a05:6870:b528:b0:14f:bb7c:6377 with SMTP id v40-20020a056870b52800b0014fbb7c6377mr7115919oap.31.1672163180135;
        Tue, 27 Dec 2022 09:46:20 -0800 (PST)
Received: from [10.0.2.15] (216.106.68.145.reverse.socket.net. [216.106.68.145])
        by smtp.googlemail.com with ESMTPSA id o13-20020a056870968d00b0014f81d27ce3sm6008097oaq.55.2022.12.27.09.46.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Dec 2022 09:46:19 -0800 (PST)
Message-ID: <c412832e-5dbe-20bb-f29f-1ef8a5cb8582@gmail.com>
Date: Tue, 27 Dec 2022 11:33:54 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 06/10] band: add band_chandef_width_to_string
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20221220214318.2041986-1-prestwoj@gmail.com>
 <20221220214318.2041986-6-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20221220214318.2041986-6-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 12/20/22 15:43, James Prestwood wrote:
> ---
>   src/band.c | 20 ++++++++++++++++++++
>   src/band.h |  1 +
>   2 files changed, 21 insertions(+)
> 

Patch 6 & 7 applied, thanks.

Regards,
-Denis

