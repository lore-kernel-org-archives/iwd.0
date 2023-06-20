Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299F310E3
	for <iwd@lists.linux.dev>; Tue, 20 Jun 2023 01:38:33 +0000 (UTC)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-1ab19a88324so687000fac.1
        for <iwd@lists.linux.dev>; Mon, 19 Jun 2023 18:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687225113; x=1689817113;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WbPZDxDmubA05v/XPgLWeJ9Tbgx7LambOFMu15dQIJU=;
        b=gmcXSct3xYEO32q8pJLhX2lIxXEcIoA1wioBHSZ8Js41/lZivHCucbyULLj3JINFJt
         jNonMGBWZPEWbLs69RAlVzYoDChxiaK9mmeFEP1RSJ3CCc+o7UppljnHWtqZHovkGc/a
         9uqo/kf6LJhGDCZYrPX5Eg6NiWik8QErvul7SLj2wG8yGeWcezQpIE/LS0voHYH48y0y
         6CkNt1TCgILXPn2DA9YFN4aX+TK8loRc0lfa3QgKElr/XYduV2aOGMnVJFNRgy//gz++
         VBd1Xk9KOwqlGnCTT0q2mNIA5J3VwPWaE4Y/2clnhqPO5uAzKamZj7cbJMW/IgN6Jw2U
         kgqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687225113; x=1689817113;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WbPZDxDmubA05v/XPgLWeJ9Tbgx7LambOFMu15dQIJU=;
        b=apumnBR+62rJj7InRrO9P2ykBEYCPGg5fI4A93+tnrCG79ms4HjyXZMwNlIc+mePgU
         MT1emJ2Vds9r9XIEV8R3HNf2hq3OvtSaThLn6OUtdOgHtO5PnRDOPvLsM0XQq2D3XLeK
         qyAH187747nNlHw4NAJbTzSKsTBRX6m7A3WQnwSnwuM7B8tiCvjEvmAf+QEeqIliVw4i
         ezgOXjuP9y37WurL6S68XqvMRQY+lfZiPVQ+A/j/w7v+u31inEDEsRwrmAHce+7VKgnE
         FFNreYrWYapmIDRmSF9qJtUIaMwrfEb9dD4qq4+h2eAQytuK8Od0Hs3QAsg2+Ov50b9a
         ynTA==
X-Gm-Message-State: AC+VfDxfW3wAWIWl+G7lwSWE1MrkV0ZJv31sN4z0+jPDw8pltjVMnzQk
	OxUNonY/M3u/oLwwtowSJ8o=
X-Google-Smtp-Source: ACHHUZ5sdA2X8tdt20SBpICN43/yGOJTw5vNFOwKjnJ7fGzPxzpmnyhJAnWRrrGeNBdJhPHwNWGaWw==
X-Received: by 2002:a05:6870:e7c5:b0:1aa:1c65:2b6 with SMTP id q5-20020a056870e7c500b001aa1c6502b6mr2518596oak.21.1687225112956;
        Mon, 19 Jun 2023 18:38:32 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id pd15-20020a0568701f0f00b001aa28348373sm639647oab.23.2023.06.19.18.38.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 18:38:32 -0700 (PDT)
Message-ID: <1d6dc32a-7576-3e78-ad35-51d1ff3eda73@gmail.com>
Date: Mon, 19 Jun 2023 20:25:31 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 1/3] netdev: move GETLINK into its own function, track
 command ID
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20230619180922.231506-1-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20230619180922.231506-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 6/19/23 13:09, James Prestwood wrote:
> Move this logic into its own function and track the command ID
> so it can be canceled in case of netdev going down.
> ---
>   src/netdev.c | 51 +++++++++++++++++++++++++++++++++------------------
>   1 file changed, 33 insertions(+), 18 deletions(-)
> 
> v3:
>   * Zero get_link_cmd_id in callback
> 

All applied, thanks.

Regards,
-Denis

