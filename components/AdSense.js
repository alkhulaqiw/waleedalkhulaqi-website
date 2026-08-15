/*
 Simple reusable AdSense component (returns HTML string).
 Replace slot when using it: REPLACE_WITH_AD_SLOT
*/
export default function AdSense(slot = 'REPLACE_WITH_AD_SLOT') {
  return `
<ins class="adsbygoogle"
     style="display:block"
     data-ad-client="ca-pub-1664033422008447"
     data-ad-slot="${slot}"
     data-ad-format="auto"
     data-full-width-responsive="true"></ins>
<script>
  (adsbygoogle = window.adsbygoogle || []).push({});
</script>`;
}
