(defun google-search-url (query)
(format "http://www.google.co.jp/search?q=%s&hl=ja&num=100&as_qdr=y5&lr=lang_ja"
(url-hexify-string query)))

(defun google-search (query)
(interactive "sGoogle: ")
(browse-url (google-search-url query)))

(defun alc-search-url (query)
  (format "http://eow.alc.co.jp/search?q=%s&ref=sa"
(url-hexify-string query)))

(defun alc-search (query)
(interactive "salc: ")
(browse-url (alc-search-url query)))
