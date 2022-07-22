Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E529D4A2C
	for <iwd@lists.linux.dev>; Fri, 22 Jul 2022 17:56:18 +0000 (UTC)
Received: by mail-oi1-f175.google.com with SMTP id bb16so6297412oib.11
        for <iwd@lists.linux.dev>; Fri, 22 Jul 2022 10:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=zrPNzYvVZGSBIRWPda8MU1qgnztCWIicc/KJHIgLxUQ=;
        b=Ig22I5YaaY3ZysO1xYhLEh4HwT41tUpofgaB3mIAInAjPRwoKHZKr+DBglT7m9dBzI
         jPxQZLAlyu3XLbQe6oYNJ9L3VhSb5Iv/PWtOo3cN0iFXXxLaBQLYMAGqu7IPbqKYcKdb
         K8HON3u3iU/CETkc1byTw7ZA1ZiCiNJY8Opy0XbMDWxDeaeo5PDuqFGLI3AaPBjVT1kp
         fbIT+4+EgzKH0lQDXyvX+R30l4G5d1GTpAqOduhuVZZVgZ2aWuEtHhDkOkZAgViSKQtV
         n5QqjeGdPt4TDcgFD/jVdpBYtJbi3DAyAnkyTmf+KheZyIurP6ZMb0cuBC7Gjrk+3qDo
         33qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zrPNzYvVZGSBIRWPda8MU1qgnztCWIicc/KJHIgLxUQ=;
        b=zaq0PVgWfPV/8ROwxbwFIRfYlFhvsEC145bQJbIUpcu0mzn/HkQSksVvYT2bYBoBke
         eXEc0bTzLJtJNNrulu2ELMNbaKxd3Eujh0OvDgBsXmsfZTOFxfiEb0KTIaBvm3JDu8ks
         SudtSS7QhD8M79MP007xuk21BhYfr3H8S65SbY/9SjDqQGY6pX8ETfl511URbyuy34vw
         tMMWMAUj9/VBAquctdSNCFimRfx9AtwDugjfZm+B9vkJ0w3iuXhsffN6JHWe4K/XvpXh
         a8EZewtMg8LnaFgAI8h104cXO29k4mXvdmPpgzGzam4x+5ltUHApGiDr0qj0JV5RkEjj
         V1gg==
X-Gm-Message-State: AJIora99PNSaxra/OTAxthdIHzDlH9Yy4VLvDk2DX6t7iYZPSU951kDI
	QCWzy6+JCR1w7NsvmsOAlGc69SXxsTQ=
X-Google-Smtp-Source: AGRyM1tEdPmFc1aDFVUoH91TPzcQRmaIWFHeyC/b+jQ0uyhkzvjNkgv2ulMYq7xvybJ6FLMlUXppqg==
X-Received: by 2002:aca:3cd6:0:b0:33a:a673:2926 with SMTP id j205-20020aca3cd6000000b0033aa6732926mr434213oia.40.1658512577930;
        Fri, 22 Jul 2022 10:56:17 -0700 (PDT)
Received: from [10.0.2.15] ([136.32.1.70])
        by smtp.googlemail.com with ESMTPSA id c17-20020a056870b29100b000e686d1386dsm2567176oao.7.2022.07.22.10.56.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 10:56:17 -0700 (PDT)
Message-ID: <692012c2-ff3f-185a-47de-f09d99311296@gmail.com>
Date: Fri, 22 Jul 2022 12:38:34 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 5/7] manager: re-dump wiphy on regulatory change
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20220722163417.1119334-1-prestwoj@gmail.com>
 <20220722163417.1119334-5-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220722163417.1119334-5-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 7/22/22 11:34, James Prestwood wrote:
> This is required due to the kernel not waiting for regulatory updates before
> sending the wiphy dump. The initial dump usually contains all supported
> frequencies, none of which are disabled. Later, the regulatory subsystem
> populates the frequency list which can significantly limit allowed frequencies.
> 
> Even disregarding this problem, any regulatory update will modify the allowed
> frequencies so re-dumping wiphy should still be done on a regulatory change.

git likes it if the description lines are limited to 72 columns.

> ---
>   src/manager.c | 58 ++++++++++++++++++++++++++++++++++++++++++---------
>   1 file changed, 48 insertions(+), 10 deletions(-)
> 
> diff --git a/src/manager.c b/src/manager.c
> index ca29e110..c8d56a99 100644
> --- a/src/manager.c
> +++ b/src/manager.c
> @@ -666,6 +666,29 @@ static int manager_wiphy_filtered_dump(uint32_t wiphy_id,
>   	return 0;
>   }
>   
> +static unsigned int manager_dump_wiphy(uint32_t wiphy_id)
> +{
> +	struct l_genl_msg *msg;
> +	unsigned int wiphy_dump;
> +
> +	msg = l_genl_msg_new_sized(NL80211_CMD_GET_WIPHY, 128);
> +
> +	if (wiphy_id)

Do note that phys start numbering at 0.  So this is probably not going to work.

> +		l_genl_msg_append_attr(msg, NL80211_ATTR_WIPHY, 4, &wiphy_id);
> +
> +	l_genl_msg_append_attr(msg, NL80211_ATTR_SPLIT_WIPHY_DUMP, 0, NULL);
> +	wiphy_dump = l_genl_family_dump(nl80211, msg,
> +						manager_wiphy_dump_callback,

Are the parsers really setup to free-and-re-parse the wiphy dump information? 
Perhaps using a callback that would parse only a subset of the information would 
be better?

> +						NULL,
> +						manager_wiphy_dump_done);
> +	if (!wiphy_dump) {
> +		l_error("Wiphy information dump failed");
> +		l_genl_msg_unref(msg);
> +	}
> +
> +	return wiphy_dump;
> +}
> +
>   static void manager_config_notify(struct l_genl_msg *msg, void *user_data)
>   {
>   	uint8_t cmd;

Regards,
-Denis
