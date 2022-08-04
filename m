Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E9F7C
	for <iwd@lists.linux.dev>; Thu,  4 Aug 2022 17:06:38 +0000 (UTC)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-10ec41637b3so232040fac.4
        for <iwd@lists.linux.dev>; Thu, 04 Aug 2022 10:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=Pm6Fg7+689KeRTx8er3osU2ucx5lzmgjlpfDsH0i6jQ=;
        b=H+N13BhD7hBi/KLGku1OuhcRqqXTtlDbhBswkwMjLO7zCrkNFkdltg4884tvw6St3f
         RVj0cIWB+eKP/AnBgqMQHjXXEQTXoku5gALmBaSRiZQA2RY9aCYFTyfVqlyx9q7CBtxC
         IcuJ1BoBRle+n3q7pRyKJ04+bBDiGG0QsvLL1+e15H5DFMsphlVCXj5VR13ZyWPHATTI
         RJ4qMHq5JfmRRf5Joo9i5J+jiaQeG3N6mEpLfesj8Udw0YOYn1X/PJTPD8SWHFrT9Cq0
         JG7eMMuK+uU459JDamqHKvr39KS0hXRGCUN0caoxEC5lQd04L63x7Jk7xDYJY2uw6Ovm
         mmuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Pm6Fg7+689KeRTx8er3osU2ucx5lzmgjlpfDsH0i6jQ=;
        b=bvkx5fwa2kgJyXeDyb1uBfJNCvyWqFkII+XXX0x4Mn0TdauoA+PPgVE7pskHTGwNRn
         YbfghJrZKLlF5Y8dmxmDRugDq3d7WN0kAeszyvBvHeIv8WSMyhUiYa6olPV2eg51g1xg
         UHWWqN904dwBB6DJnFIKu0VmXV66UNw/Cw0X0Zh65NdHig+CTPOkWHQ+eUmwb07+qpmt
         /DS1H98F6rRwyQKq+XKbUFrtwLcT0wtuzdbcmtD+9938qNJXA0DrfKu1WJAg9NedlUVN
         L/7f34BLe4tXel40X2GRqHldCVaq4Rgsukiyql+i62oEV36PUU0J85wt2oFlCRw15nBb
         u6Qw==
X-Gm-Message-State: ACgBeo25i8XbbxeQYsLLof/qW5FVNvoiYzrSTZnAt+1oPR/70GSTesxL
	HaJai8yQ1lrmw82gzEio1KM=
X-Google-Smtp-Source: AA6agR5kO7o8/qulZ3PyKlktTqq35N497p9qlDARub7rKJ7dyasiyGDKJUFJxV37JBH3hYku7RsTug==
X-Received: by 2002:a05:6870:f149:b0:dd:f3b0:986d with SMTP id l9-20020a056870f14900b000ddf3b0986dmr4671394oac.148.1659632797632;
        Thu, 04 Aug 2022 10:06:37 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id f17-20020a056870899100b0010d3438b20esm228178oaq.29.2022.08.04.10.06.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 10:06:37 -0700 (PDT)
Message-ID: <fce45fa4-cf76-63e8-a53e-09fbf0a4a426@gmail.com>
Date: Thu, 4 Aug 2022 11:48:25 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 09/13] wiphy: add wiphy_country_is_unknown
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20220803213644.277534-1-prestwoj@gmail.com>
 <20220803213644.277534-9-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220803213644.277534-9-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 8/3/22 16:36, James Prestwood wrote:
> A helper to check whether the country code corresponds to a
> real country, or some special code indicating the country isn't
> yet set. For now, the special codes are OO (world roaming) and
> XX (unknown entity).
> ---
>   src/wiphy.c | 16 ++++++++++++++++
>   src/wiphy.h |  1 +
>   2 files changed, 17 insertions(+)
> 

Applied, thanks.

Regards,
-Denis

