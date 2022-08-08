Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE257A
	for <iwd@lists.linux.dev>; Mon,  8 Aug 2022 18:57:30 +0000 (UTC)
Received: by mail-ot1-f47.google.com with SMTP id j66-20020a9d17c8000000b00636b0377a8cso6105129otj.1
        for <iwd@lists.linux.dev>; Mon, 08 Aug 2022 11:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=/uZwzgEHGK8ZZL1UYhseBavty7E0sVWJwb/PDF+4t/o=;
        b=EySuDKvdbsDrKgXcJLDZHN3Eedv/s3GBxHVdDHOTf8ZO/R8aT9oLrwrqfsf+iBwBKo
         ONRPmWnbUx2BAlaiORhdrg7P9Zj7m6wf+9J9dcuMt8rh+4hgYOVU+BA1aNjt6Khg9Oqg
         cM18CG0VxA6DhaH/a8JFdOtZshrVAU7+sO95RSRousopictYUpMXC9tmZugNCI3AgUcT
         5QfJ6m2fP/Pd+eLuuzuc0SD6PkpWgRBbI8vBDLv/Q6aprQbjyD7TJM/JH8MQ9RT+ipA1
         8Uv6ScAcSwnZXW0ozrHNAGa8zPdAWb802cQBQqKt56qKNhcmi1aIo6VILvXwNfW2zIOl
         k8XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=/uZwzgEHGK8ZZL1UYhseBavty7E0sVWJwb/PDF+4t/o=;
        b=qv9C7L7ckv4PAgjBbFZpksDGjsyVYjGEV531yzdqehOnabLx+asLCA0GM7uF6+7wyy
         ROjacXnP1NlNFNcQwpDmTUgcxnE1J1mdi39iJX5qqAcPtDboX3FEjLTowu+nBpcQc1JI
         hIRZ/ZLZDhOWCWvwgFYBfP2K0cZdkZwOTevbxgViyz+6dzYBRBNXMcDO2k6XwosZlG2J
         eAyf5owQB6kurh4J27T0b6UhmQphCgEmW+mRyIptObdG3Cre2fnMtK834ZQdZJLHbfLi
         P7luVUa4YBoen5qpoiTEPJZYNs+op9QNPC3/6aTG8CqZQRaos+qe6tet20HRGqDwzuEl
         2w4A==
X-Gm-Message-State: ACgBeo3r3hFH3PClsJloEa/urPSvrPjDiiAy9ZOizSLiKxzvnk83eYFY
	ldiahV+Dxj9wYylR026p8aI=
X-Google-Smtp-Source: AA6agR6oaK2WIGxA9lWryoKt+hnIWjghhpYVg47mAQsRf/5TlWqdykxldwXUkaQvgIsPY7ovP1/Rew==
X-Received: by 2002:a05:6830:25c3:b0:61c:bf4f:1807 with SMTP id d3-20020a05683025c300b0061cbf4f1807mr7271477otu.354.1659985049386;
        Mon, 08 Aug 2022 11:57:29 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id r19-20020a056830419300b00636c6108dfasm1587522otu.28.2022.08.08.11.57.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 11:57:29 -0700 (PDT)
Message-ID: <93d0fbcc-931b-4d95-eaf6-646846d6ed29@gmail.com>
Date: Mon, 8 Aug 2022 13:37:56 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/4] handshake: add force_default_owe_group flag
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20220808182259.19402-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220808182259.19402-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 8/8/22 13:22, James Prestwood wrote:
> Indicates the OWE SM should only use the default group
> ---
>   src/handshake.h | 1 +
>   1 file changed, 1 insertion(+)
> 

All applied, thanks.

Regards,
-Denis

