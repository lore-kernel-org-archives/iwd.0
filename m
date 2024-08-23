Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6C118C330
	for <iwd@lists.linux.dev>; Fri, 23 Aug 2024 17:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724433591; cv=none; b=iZLH9plGU/2l257Kr0PK2XiMeF76fL5qt+QTvkFD4tIJ90D2tSjZOhXpAPk07QB1CfqyZQ7rltxfIjVHXUBjEoUuRV/5oIkHSoLyOMuZQC2dSwAZP3bkO1wGIzqSGJV1vrBUAC+nSKrDtn+UUW8pgUAcZQQVP+nqXxweS7sazXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724433591; c=relaxed/simple;
	bh=T7vXahUN6VW1qJ5yGRj9xjmoJa4bJHvdEvoDyld0if4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JKH3rJMBhgmnDQDna3B3oFtN15lh5y2LmsN2YNqyN0Myd0mDL5rQoXhOqeVWCrpCVMBvkkfgpX/4GMeMIQLr1A/WkxvYpmDpWcEdS7pkDgVYDABWofosw+c3r3tOHdV3yqpx1xUjS48r23EIjT1t2sk1jg4XUkbYIUrBbtsShzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cy3FkYqs; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cy3FkYqs"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7a1d7a544e7so135290785a.3
        for <iwd@lists.linux.dev>; Fri, 23 Aug 2024 10:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724433589; x=1725038389; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Opi/OLBGYtWneDkZiOONy5u0XXps+h3vxWcfz0nCbvU=;
        b=Cy3FkYqsyvvPbO2n+y0/cwEYOSae6ADEtxk2z9yVbEc8PmT6L4ddKyZSumDKEIIs9j
         TNWjhrhyUvo3MKoujoH+RWv9nWQXSfeboGRmqAtUoYIN77nSmOMcQ5L6dWdpVRtTUHL0
         +AS4nrIrhhhEg2zF5nivAIaRYmcqTnEBtlWzzIKUE+bAjRjOck51A+w/+FY6F4vaI1fQ
         a5HmQhuPo1wngGKUrflB7Ch6aXpwzwcRP1Jav7TNqA3Dl1MUDpUyOTNUDRblw9GfbpQC
         uqxlufgQ25N82uZmF5hKN4bRu4XNWiUmSwVpyMiQa1ey5gODCbV7mGjeq0AXVek292mE
         BUmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724433589; x=1725038389;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Opi/OLBGYtWneDkZiOONy5u0XXps+h3vxWcfz0nCbvU=;
        b=hJXu4QgH4U5UYAluYwcC0SFsAmgR9eVhoPSSAuSdMV1vX8y16ZSzjQLQ0qegnFHxJb
         bnkEbFg+YaE2KuauaR+R21WFbGE7wtFy6G+4OTKycyMy7jdE+KGbHaJccvkFM9OWAEdW
         pMxHZq7yhVEDDo2N55VhooGFj2UZ8mLZKGB1JyMLhShAOXL60OWYkn/E3WdDl3M0lmfr
         ZKQPflv8+Yz3NkLvBut9WN/wAt1eNqMKOgQnnh4PBeGErXQxTF6vUMMzXKNaaf5ZS2Ud
         a6akfLESH35oYngGT3B9kTLABkblAtWXrIpRzdclUlj5RVWk4BmRbPG1KlCRsGhhkhHB
         yPgw==
X-Forwarded-Encrypted: i=1; AJvYcCUK4F+7dj0uPeJZCseHFQSt5fCzesvw7k8PyLctlsyUWK44xqssfP5ZyZJQM/qkwQSZKgM=@lists.linux.dev
X-Gm-Message-State: AOJu0YxAZh6V1xOaChFb54Mek/6YuA/1TvNVh4DI+PJnEd66BDLdwbaC
	9qKCmLCPodlU2XqrrODG4Epbjsl92iT3Be0iXQ2GUzGshG2BWdx2Lki5QQ==
X-Google-Smtp-Source: AGHT+IEI7e3LdWITpVwChMBZBi8j85XZ2s0Xx/RrgXRfsRrvfOxMjkMs8tLrlEfBJcgrwFB4afOupA==
X-Received: by 2002:a05:620a:1726:b0:79d:79c4:e0a3 with SMTP id af79cd13be357-7a6897871e6mr370635485a.44.1724433588750;
        Fri, 23 Aug 2024 10:19:48 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f341dfdsm197353685a.34.2024.08.23.10.19.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 10:19:48 -0700 (PDT)
Message-ID: <74f520a4-73b2-461c-8960-44589d63fb46@gmail.com>
Date: Fri, 23 Aug 2024 10:19:46 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] monitor: Print rmnet flags
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20240823160901.474421-1-denkenz@gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <20240823160901.474421-1-denkenz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Denis,

On 8/23/24 9:08 AM, Denis Kenzior wrote:
> ---
>   monitor/nlmon.c | 36 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 36 insertions(+)
>
> diff --git a/monitor/nlmon.c b/monitor/nlmon.c
> index 214246ea72c2..fdf16fbe7a04 100644
> --- a/monitor/nlmon.c
> +++ b/monitor/nlmon.c
> @@ -37,6 +37,7 @@
>   #include <linux/if.h>
>   #include <linux/if_packet.h>
>   #include <linux/if_ether.h>
> +#include <linux/if_link.h>
>   #include <linux/netlink.h>
>   #include <linux/genetlink.h>
>   #include <linux/rtnetlink.h>
> @@ -7597,8 +7598,43 @@ static void flags_str(const struct flag_names *table,
>   	pos += sprintf(str + pos, "]");
>   }
>   
> +static void print_rmnet_flags(unsigned int indent,
> +					const char *label, uint32_t flags)
> +{
> +	if (flags & RMNET_FLAGS_INGRESS_DEAGGREGATION)
> +		print_attr(indent, "%s:%s", label, "deaggregation");
> +	if (flags & RMNET_FLAGS_INGRESS_MAP_COMMANDS)
> +		print_attr(indent, "%s:%s", label, "map commands");
> +	if (flags & RMNET_FLAGS_INGRESS_MAP_CKSUMV4)
> +		print_attr(indent, "%s:%s", label, "ingress_mapv4");
> +	if (flags & RMNET_FLAGS_EGRESS_MAP_CKSUMV4)
> +		print_attr(indent, "%s:%s", label, "egress_mapv4");
> +	if (flags & RMNET_FLAGS_INGRESS_MAP_CKSUMV5)
> +		print_attr(indent, "%s:%s", label, "ingress_mapv5");
> +	if (flags & RMNET_FLAGS_EGRESS_MAP_CKSUMV5)
> +		print_attr(indent, "%s:%s", label, "egress_mapv5");
> +}
> +
> +static void print_ifla_rmnet_flags(unsigned int indent, const char *str,
> +						const void *buf, uint16_t size)
> +{
> +	struct ifla_rmnet_flags flags;
> +
> +	if (size != 8) {
> +		printf("malformed packet\n");
> +		return;
> +	}
> +
> +	memcpy(&flags, buf, size);
> +
> +	print_rmnet_flags(indent + 1, "Flags", flags.flags);
> +	print_rmnet_flags(indent + 1, "Mask", flags.mask);
> +}
> +
>   static struct attr_entry link_info_data_entry[] = {
>   	{ IFLA_RMNET_MUX_ID,	"RMNet Mux Id",		ATTR_U16 },
> +	{ IFLA_RMNET_FLAGS,	"RMNet Flags",		ATTR_CUSTOM,
> +					{ .function = print_ifla_rmnet_flags } },
>   	{ },
>   };
>   
LGTM
