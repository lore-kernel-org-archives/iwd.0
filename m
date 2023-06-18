Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4FA1FD1
	for <iwd@lists.linux.dev>; Sun, 18 Jun 2023 19:23:35 +0000 (UTC)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-1a9ae7cc01dso1682632fac.3
        for <iwd@lists.linux.dev>; Sun, 18 Jun 2023 12:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687116214; x=1689708214;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s5nNW6AuCYKiq1hfbphQfNtF2+5abjFZPAWgGEqkZW4=;
        b=ko/T+mlnD5kPzM954ai+9XcTe8TbPrZ5C1eDNJ4R1paHqKSwQOQ7KITa86U0B3OymY
         k9C7WCeNzV7YQJVCPvbhBxBoi7oTdP370kL1JOcu67UwyX+6yteDMSoO18MErUNo+6aY
         teiamSvY8DkJfIjvNTY5EG17Ip1KQkKPzSnsjHmGNUGC6c+mIGFdN8bf5nP9yORakRMZ
         Ls0049Cq+8wwqaN0Y55SW3oQYlsiNU8IaYXjSr6TDhplKs/j+zqJKLPD0KrBXEmfKrZY
         TKxzju3ayzHvtFyjVpmCW75yDb54JZcp9Fs8tbIXPubkLpKjzLrmpfzS9wIIyjQk4stF
         WOaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687116214; x=1689708214;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s5nNW6AuCYKiq1hfbphQfNtF2+5abjFZPAWgGEqkZW4=;
        b=TOk+rZxMr27um2IMXBUtqHVURC1TS4HJFWFROUOtSq6AxA1a2Uk6dIHvetIy7YIFCb
         pAK5S1Bnh2b8s2xDuYOo9ZFKKNyCXDGYzqAJycqiixW6TUAn6gyczxMovEW9xFnMss4i
         +7N3ua7Cmjze30FW+l+NuqtzJyR7ZBUtdMNtQiSDdiil2QJubSHtpR4Yl9N/Jw4uwtbK
         qL+zgQfllrcX/Tt63+B7psIQ9vVANzR8HW8jMiVoa90SqGU6/VzJwGzubuiyct3r6H3e
         fc3rmLFDYrNMJuiLZyg0+bWcGo47UdZUrNVIVhQ3ZEkyWpoTAAXJQzsX/BCF/fVe/pRK
         wH1A==
X-Gm-Message-State: AC+VfDzSENPoEgmBva+jzF6XTILcSS1ucM3KQZEVr6xmSg8SLSKlVoNN
	az7aYlYIdNhw4dTR1D8fH5ZOZLOE9F8=
X-Google-Smtp-Source: ACHHUZ5MSJ1zAMmFch5HRAZRfWDaM3ffT1m9Lj/OepMx+zaEzWRn5fM88u6ffdLopEMya09zEoWY1A==
X-Received: by 2002:a05:6870:e503:b0:1a9:dbe9:82df with SMTP id y3-20020a056870e50300b001a9dbe982dfmr2462563oag.26.1687116214379;
        Sun, 18 Jun 2023 12:23:34 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id w24-20020a4ae4d8000000b005584e0c8f9csm8784897oov.3.2023.06.18.12.23.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jun 2023 12:23:33 -0700 (PDT)
Message-ID: <8e99b15b-7730-3c25-7811-e1cef6f2d6e4@gmail.com>
Date: Sun, 18 Jun 2023 14:11:03 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 5/7] netdev: disable power save if required
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20230615192415.1718516-1-prestwoj@gmail.com>
 <20230615192415.1718516-5-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20230615192415.1718516-5-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 6/15/23 14:24, James Prestwood wrote:
> Disable power save if the wiphy indicates its needed. Do this
> before issuing GET_LINK so the netdev doesn't signal its up until
> power save is disabled.
> ---
>   src/netdev.c | 80 +++++++++++++++++++++++++++++++++++++++++++---------
>   1 file changed, 66 insertions(+), 14 deletions(-)
> 

<snip>

> +static void netdev_disable_ps_cb(struct l_genl_msg *msg, void *user_data)
> +{
> +	int err = l_genl_msg_get_error(msg);
> +	uint32_t ifindex = L_PTR_TO_UINT(user_data);
> +
> +	/* Can't do anything about it but inform the user */
> +	if (err < 0) {
> +		l_error("Failed to disable power save for ifindex %u (%s: %d)",
> +				ifindex, strerror(-err), err);
> +		return;
> +	}
> +
> +	l_debug("Disabled power save for ifindex %u", ifindex);
> +}
> +
> +static void netdev_disable_ps_destroy(void *user_data)
> +{
> +	uint32_t ifindex = L_PTR_TO_UINT(user_data);
> +
> +	netdev_get_link(ifindex);

So why do we do this in the destroy callback?  What happens if this operation is 
canceled (maybe by hot-unplug?)

> +}
> +

<snip>

>   
> -	l_free(rtmmsg);
> +	if (wiphy_disable_power_save(wiphy)) {
> +		/* Wait to issue GET_LINK until PS is disabled */
> +		if (netdev_disable_power_save(ifindex))

Should we be saving a command id here so we can cancel this operation in case of 
hot-unplug?

Ideally we should switch to using l_genl_family_new per netdev so that all the 
outstanding commands are auto-canceled, but this might require some care.

> +			return netdev;
> +	}
>   
> -	netdev_setup_interface(netdev);
> +	netdev_get_link(ifindex);

We should be saving the command id here too, but as a separate fix.

>   
>   	return netdev;
>   }

Regards,
-Denis
